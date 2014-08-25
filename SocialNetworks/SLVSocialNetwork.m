//
//  SLVLinkedInApi.m
//  Social Networks
//
//  Created by Ostap R on 18.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import "SLVSocialNetwork.h"
#import "SLVTokenSocialManager.h"

@interface SLVSocialNetwork () <SLVTokenSocialManagerDelegate>

@property(nonatomic) Users * user;
@property (nonatomic) SLVTokenSocialManager * tokenManager;

@end

@implementation SLVSocialNetwork


-(void)receivedToken:(Users *)user
{
    self.user=user;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userData" object:self];
}


-(void)makeShare
{
    if(![self hasUser])
        return;
    
    
    
    NSString * urlShare;
    NSString * urlOAuth;
    NSMutableString * urlAbsolutePath;
    NSMutableURLRequest * request;
    NSData * json;
    
    switch (self.serviceType)
    {
        case ServiceTypeFacebook:
            break;
        case ServiceTypeGPlus:
            break;
        case ServiceTypeLinkedIn:
        {
            urlShare=@"https://api.linkedin.com/v1/people/~/shares";
            urlOAuth=@"?oauth2_access_token=";
            urlAbsolutePath=[[NSMutableString alloc] initWithString:urlShare];
            [urlAbsolutePath appendString:urlOAuth];
            [urlAbsolutePath appendString:self.user.token];
            
            request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlAbsolutePath]];
            [request setHTTPMethod:@"POST"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request addValue:@"json" forHTTPHeaderField:@"x-li-format"];
            
            NSMutableDictionary * root=[[NSMutableDictionary alloc] init];
            NSMutableDictionary * visibility=[[NSMutableDictionary alloc] init];
            [root setObject:@"woiejr" forKey:@"comment"]; //Message for sharing
            [root setObject:visibility forKey:@"visibility"];
            [visibility setObject:@"anyone" forKey:@"code"];
            json=[NSJSONSerialization dataWithJSONObject:root options:NSJSONWritingPrettyPrinted error:nil];
            
        }
            break;
        default: break;
            
    }


    [request setHTTPBody:json];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         [self.delegate madeShare:dic];
     }
     ];

}


-(BOOL)hasUser
{
    if(!self.user)
    {self.tokenManager=[SLVTokenSocialManager new];
        self.tokenManager.delegate=self;
        
        [self.tokenManager getUser];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeShare) name:@"userData" object:nil];
        return NO;
    }
    return YES;
}

@end

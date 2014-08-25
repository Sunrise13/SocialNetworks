//
//  SLVTokenSocialManager.m
//  SocialNetworks
//
//  Created by Ostap R on 22.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import "SLVTokenSocialManager.h"
#import "SLVSocialNetwork.h"

@interface SLVTokenSocialManager()

@property (nonatomic) SLVOAuthSetup *oauthSetup;
@property (nonatomic) SLVDBManager *dbManager;

@end

@implementation SLVTokenSocialManager

-(void)getUser
{
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"Users"];
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"serviceType==[c]\"LinkedIn\""]; //serviceType
    [request setPredicate:pred];
    NSArray *service=[self.dbManager.context executeFetchRequest:request error:nil];
    if([service count]==0)
    {
        self.oauthSetup=[SLVOAuthSetup new];
        self.oauthSetup.delegate=self;
        [self.oauthSetup setupWithServiceType:self.delegate.serviceType];
        
    }
    else
    {
        [self.delegate receivedToken:service[0]];
    }
    
    
}

-(void)userData:(Users *)user
{
    [self.delegate receivedToken:user];
}


@end

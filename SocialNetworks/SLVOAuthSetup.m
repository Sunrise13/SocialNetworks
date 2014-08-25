//
//  SLVOAuthSetup.m
//  SocialSharing
//
//  Created by Ostap R on 19.08.14.
//  Copyright (c) 2014 SoftServe LV-120. All rights reserved.
//

#import "SLVOAuthSetup.h"
#import "SLVDBManager.h"
#import "Users.h"
static  NSString * kLinkedInApiKey=@"772ojbop21zpbj";
static  NSString * kLinkedInSecretKey=@"SEFTnXX310DnJtE6";

//static  NSString * kOdnoklassnikiAppId = @"1099234816";
//static  NSString * kOdnoklassnikiApiKey = @"CBAPPFICEBABABABA";
//static  NSString * kOdnoklassnikiSecretKey = @"790E117F49C34E0674AF5924";

static  NSString * kOdnoklassnikiAppId = @"1099077376";
static  NSString * kOdnoklassnikiApiKey = @"CBAIJDICEBABABABA";
static  NSString * kOdnoklassnikiSecretKey  = @"5DB622C86B3A9B09648A47F3";


@interface SLVOAuthSetup() <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic) ServiceType serviceType;

@end

@implementation SLVOAuthSetup

-(void)setupWithServiceType:(ServiceType)serviceType
{
    self.serviceType=serviceType;
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:self animated:YES completion:nil];
    
    CGRect web=CGRectMake(0, 0, 700, 700);
    self.webView=[[UIWebView alloc] initWithFrame:web];
    self.webView.delegate=self;
    self.webView.scalesPageToFit=YES;
    [self.view addSubview:self.webView];
    
    NSMutableString *urlAbsolutePath;
    NSURLRequest *request;
    
    
    
    switch (serviceType)
    {
        case ServiceTypeLinkedIn:
        {
            urlAbsolutePath=[[NSMutableString alloc] initWithString:@"https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id="];
            [urlAbsolutePath appendString:kLinkedInApiKey];
            [urlAbsolutePath appendString:@"&state="];
            
            NSDate *data=[NSDate date];
            NSTimeInterval currentTimestamp=[data timeIntervalSince1970];
            NSNumber *timestampObj=[NSNumber numberWithDouble:currentTimestamp];
            [urlAbsolutePath appendString:[timestampObj stringValue]];
            [urlAbsolutePath appendString:@"&redirect_uri=http://example.com"];
            request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlAbsolutePath]];
        }
            break;
        case ServiceTypeOdnoklassniki:
        {
            
        //http://www.odnoklassniki.ru/oauth/authorize?client_id={clientId}&scope={scope}&response_type={responseType}&redirect_uri={redirectUri}
            urlAbsolutePath=[[NSMutableString alloc] initWithString:@"http://www.odnoklassniki.ru/oauth/authorize?client_id="];
            [urlAbsolutePath appendString:kOdnoklassnikiAppId];
            [urlAbsolutePath appendString:@"&scope=SET_STATUS"];
            [urlAbsolutePath appendString:@"&response_type=code"];
            [urlAbsolutePath appendString:@"&redirect_uri=http%3A%2F%2Fexample.com"];
            request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlAbsolutePath]];
        }
            break;
            
        case ServiceTypeGPlus:
            break;
    }
    
     [self.webView loadRequest:request];
    
}

#pragma mark - WebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url=request.URL.absoluteString;
    NSLog(@"%@\n", url);
    
    if([url rangeOfString:@"http://example.com"].location!=NSNotFound)
    {
        NSInteger loc;
        switch (self.serviceType)
        {
            case ServiceTypeLinkedIn:
                loc=[url rangeOfString:@"code="].location;

            break;
            case ServiceTypeOdnoklassniki:
                loc = [url rangeOfString:@"code="].location;
                break;
                

        }
        if(loc!=NSNotFound)
        {
            NSString * tempToken=[self getTempTokenFromString:url];
            [self getToken:tempToken];
            return NO;
        }
        
    }
    
    return YES;
}

#pragma mark - LinkedInAuthorization

-(NSString *)getTempTokenFromString:(NSString *)path
{
    NSInteger locationBegin;
    NSInteger locationEnd;
    switch(self.serviceType)
    {
            case ServiceTypeLinkedIn:
            locationBegin=[path rangeOfString:@"code="].location+5;
            locationEnd=[path rangeOfString:@"&state="].location;
            break;
        case ServiceTypeOdnoklassniki:
            locationBegin=[path rangeOfString:@"code="].location+5;
            locationEnd=[path length];
            break;
            
    }
    
        NSRange range=NSMakeRange(locationBegin, locationEnd-locationBegin);
        NSString *tempToken=[path substringWithRange:range];

        return tempToken;
}

-(void)getToken:(NSString *)tempToken
{
    NSMutableString * absolutePath;
    NSURL * urlAbsolutePath;
    NSMutableURLRequest * request;
    
    switch (self.serviceType)
    {
        case ServiceTypeLinkedIn:
        {
            absolutePath=[[NSMutableString alloc] initWithString:@"https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code="];
            [absolutePath appendString:tempToken];
            [absolutePath appendString:@"&redirect_uri=http://example.com"];
            [absolutePath appendString:@"&client_id="];
            [absolutePath appendString:kLinkedInApiKey];
            [absolutePath appendString:@"&client_secret="];
            [absolutePath appendString:kLinkedInSecretKey];
        }
            break;
        case ServiceTypeOdnoklassniki:
        {
            //http://api.odnoklassniki.ru/oauth/token.do
            
            // code - код авторизации, полученный в ответном адресе URL пользователя
            // redirect_uri - тот же URI для переадресации, который был указан при первом вызове
            // grant_type - на данный момент поддерживается только код авторизации authorization_code
            // client_id - идентификатор приложения
            // client_secret - секретный ключ приложения
            
            absolutePath=[[NSMutableString alloc] initWithString:@"http://api.odnoklassniki.ru/oauth/token.do?code="];
            [absolutePath appendString:tempToken];
            [absolutePath appendString:@"&redirect_uri=http%3A%2F%2Fexample.com"];
            [absolutePath appendString:@"&grant_type=authorization_code"];
            [absolutePath appendString:@"&client_id="];
            [absolutePath appendString:kOdnoklassnikiAppId];
            [absolutePath appendString:@"&client_secret="];
            [absolutePath appendString:kOdnoklassnikiSecretKey];
        }
            break;
            
    }
    

    urlAbsolutePath=[NSURL URLWithString:absolutePath];
    
   request=[[NSMutableURLRequest alloc] initWithURL:urlAbsolutePath];
    [request setHTTPMethod:@"POST"];
    

    [NSURLConnection sendAsynchronousRequest:request
                                      queue:[NSOperationQueue mainQueue]
                            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {

         NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         
         Users *user;
         NSString *accessToken;
         switch (self.serviceType)
         {
             case ServiceTypeLinkedIn:
             {
                 accessToken=dic[@"access_token"];
                 user=[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:[[SLVDBManager sharedManager] context]];
                 user.serviceType=@"LinkedIn";
                 user.token=accessToken;
             }
                 break;
             case ServiceTypeOdnoklassniki:
             {
                 accessToken=dic[@"access_token"];
                 user=[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:[[SLVDBManager sharedManager] context]];
                 user.serviceType=@"Odnoklassniki";
                 user.token=accessToken;
             }
                 
         }
        
         [self.delegate userData:user];
         [self.webView removeFromSuperview];
         [[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:nil];

     }
     ];
    
}





@end





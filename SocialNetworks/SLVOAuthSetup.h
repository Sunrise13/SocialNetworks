//
//  SLVOAuthSetup.h
//  SocialSharing
//
//  Created by Ostap R on 19.08.14.
//  Copyright (c) 2014 SoftServe LV-120. All rights reserved.
//

#import "ServiceTypes.h"
@class Users;


@protocol SLVOAuthSetupDelegate <NSObject>

@required
-(void)userData:(Users *)user;

@end

@interface SLVOAuthSetup : UIViewController <UIWebViewDelegate>

@property (nonatomic) __block id<SLVOAuthSetupDelegate> delegate;

-(void)setupWithServiceType:(ServiceType)serviceType;

@end




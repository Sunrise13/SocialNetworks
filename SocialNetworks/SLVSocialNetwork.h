//
//  SLVLinkedInApi.h
//  Social Networks
//
//  Created by Ostap R on 18.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//


#import "SLVViewController.h"
#import "SLVTokenSocialManager.h"
#import "Users.h"
#import "ServiceTypes.h"



@protocol SLVSocialNetworkDelegate <NSObject>

@optional
-(void)madeShare:(NSDictionary *)shareJSON;

@end

@interface SLVSocialNetwork : NSObject

@property (nonatomic) id<SLVSocialNetworkDelegate> delegate;
@property (nonatomic) ServiceType serviceType;

-(void)makeShare;
@end

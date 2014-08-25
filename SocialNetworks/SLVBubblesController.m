//
//  SLVBubblesController.m
//  SocialSharing
//
//  Created by Oleksiy on 8/19/14.
//  Copyright (c) 2014 Oleksiy. All rights reserved.
//



#import "SLVBubblesController.h"
#import "AAShareBubbles.h"
#import "SLVSocialNetwork.h"


@interface SLVBubblesController() <AAShareBubblesDelegate>

@property (nonatomic) SLVSocialNetwork * socialNetwork;
@end


@implementation SLVBubblesController



-(void)viewDidLoad
{
    AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initWithPoint:self.view.center
                                                              radius:300
                                                              inView:self.view];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = 45; // Default is 40
    shareBubbles.showFacebookBubble = YES;
    shareBubbles.showTwitterBubble = YES;
    shareBubbles.showMailBubble = YES;
    shareBubbles.showGooglePlusBubble = YES;
    shareBubbles.showTumblrBubble = YES;
    shareBubbles.showVkBubble = YES;
    shareBubbles.showInstagramBubble = YES;
    shareBubbles.showLinkedInBubble=YES;
    [shareBubbles show];

 

}

-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook:

            break;
        case AAShareBubbleTypeTwitter:

            break;
        case AAShareBubbleTypeMail:
            NSLog(@"Email");
            break;
        case AAShareBubbleTypeGooglePlus:

            break;
        case AAShareBubbleTypeTumblr:
            NSLog(@"Tumblr");
            self.socialNetwork = [[SLVSocialNetwork alloc] init];
            self.socialNetwork.serviceType = ServiceTypeOdnoklassniki;
            [self.socialNetwork makeShare];
            break;
        case AAShareBubbleTypeVk:
            NSLog(@"Vkontakte (vk.com)");
            break;
        case AAShareBubbleTypeLinkedIn:
            NSLog(@"LinkedIn");
            self.socialNetwork=[[SLVSocialNetwork alloc] init];
            self.socialNetwork.serviceType=ServiceTypeLinkedIn;
            [self.socialNetwork makeShare];
            
           // self.linkedIn.controllerWithData=self.controllerWithData;
            //[self presentViewController:self.linkedIn animated:YES completion:nil];
            //[[[UIApplication sharedApplication] keyWindow].rootViewController.navigationController pushViewController:self.linkedIn animated:YES];
           // [self.navigationController pushViewController:self. animated:YES];
            
            break;

        default:
            break;
    }
}

-(void)aaShareBubblesDidHide {
    NSLog(@"All Bubbles hidden");
}



@end

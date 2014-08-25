//
//  SLVViewController.h
//  SocialSharing
//
//  Created by Oleksiy on 8/19/14.
//  Copyright (c) 2014 Oleksiy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SLVViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UITextView *shareText;
@property (weak, nonatomic) IBOutlet UIImageView *shareImage;

@property (strong, nonatomic) NSData *imageToShare;






 @end
    
//
//  SLVViewController.m
//  SocialSharing
//
//  Created by Oleksiy on 8/19/14.
//  Copyright (c) 2014 Oleksiy. All rights reserved.
//

#import "SLVViewController.h"
#import "SLVBubblesController.h"


@interface SLVViewController ()

@end

@implementation SLVViewController
@synthesize shareImage=_shareImage;
@synthesize shareText=_shareText;
//@synthesize imageToShare=_imageToShare;





- (IBAction)cameraPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uppload the photo" message:nil delegate:self cancelButtonTitle:@"Dissmiss" otherButtonTitles:@"Take the photo",@"Choose existing",nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //if (buttonIndex == 1 /*Take photo*/)
    //{
    //UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //imagePicker.delegate = self;
    // [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    //   [self presentViewController:imagePicker animated:YES completion:NULL];
    // }else
    if (buttonIndex == 2 /*Use existing*/)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        //[imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:NULL];
        
    }
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_shareImage setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    //_imageToShare = UIImagePNGRepresentation(image);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_shareText resignFirstResponder];
}














- (void)viewDidLoad
{
    
    //_shareText.delegate=self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
//    if ([segue.identifier isEqualToString:@"Share"]) {
//        SLVBubblesController * dController = segue.destinationViewController;
//        dController.mainController = self;
//    }
}

@end

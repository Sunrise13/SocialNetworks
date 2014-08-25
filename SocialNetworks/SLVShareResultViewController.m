//
//  SLVShareResultViewController.m
//  SocialNetworks
//
//  Created by Ostap R on 22.08.14.
//  Copyright (c) 2014 SoftServe Lv-120. All rights reserved.
//

#import "SLVShareResultViewController.h"

@interface SLVShareResultViewController ()

@end

@implementation SLVShareResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)madeShare:(NSDictionary *)shareJSON
{
    NSLog(@"%@", shareJSON);
}

@end

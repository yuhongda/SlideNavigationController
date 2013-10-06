//
//  HDViewController.m
//  SlideNavigationController
//
//  Created by Yu Hongda on 13-10-6.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import "HDViewController.h"

@interface HDViewController ()

@end

@implementation HDViewController

@synthesize slideNavigationController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)loadMasterViewClicked:(id)sender{
    MDMasterViewController *masterViewController = [[MDMasterViewController alloc] initWithNibName:@"MDMasterViewController" bundle:nil];
    
    self.slideNavigationController = [[HDSlideNavigationController alloc] initWithRootViewController:masterViewController];
    masterViewController.slide = self.slideNavigationController;
    //[self presentModalViewController:self.navigationController animated:YES];
    
    
    [self.slideNavigationController.view setFrame:CGRectMake(320.0f, 0.0f, 320.0f, 480.0f)];
    [self.slideNavigationController.view setAlpha:0.0f];
    
    
    [[UIApplication sharedApplication].delegate.window addSubview:self.slideNavigationController.view];
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn |
     UIViewAnimationOptionLayoutSubviews |
     UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [self.slideNavigationController.view setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
                         [self.slideNavigationController.view setAlpha:1.0f];
                     }
                     completion:nil];
    
}

@end

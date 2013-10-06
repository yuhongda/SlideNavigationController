//
//  HDViewController.h
//  SlideNavigationController
//
//  Created by Yu Hongda on 13-10-6.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDMasterViewController.h"
#import "HDSlideNavigationController.h"

@interface HDViewController : UIViewController{
    
    MDMasterViewController *mdMasterViewController;
    HDSlideNavigationController *slideNavigationController;
}

@property (strong, nonatomic) HDSlideNavigationController *slideNavigationController;

-(IBAction)loadMasterViewClicked:(id)sender;


@end

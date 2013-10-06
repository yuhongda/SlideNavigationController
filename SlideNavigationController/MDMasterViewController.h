//
//  MDMasterViewController.h
//  HelloiOS
//
//  Created by Yu Hongda on 13-5-19.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDDetailViewController;
@class HDSlideNavigationController;

@interface MDMasterViewController : UITableViewController
{
    NSMutableArray *listOfCDs;
    NSInteger selectedRow;
    //IBOutlet UINavigationBar *nav;
}

@property (strong, nonatomic) MDDetailViewController *detailViewController;
@property (strong, nonatomic) HDSlideNavigationController *slide;
//@property (nonatomic,retain) UINavigationBar *nav;

@end


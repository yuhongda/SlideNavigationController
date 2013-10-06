//
//  MDDetailViewController.m
//  HelloiOS
//
//  Created by Yu Hongda on 13-5-19.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import "MDDetailViewController.h"
#import "Album.h"

@interface MDDetailViewController ()

@end

@implementation MDDetailViewController


- (void)dealloc
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        if (self.detailItem) {
            self.title = [[NSString alloc] initWithFormat:@"%d. %@", ((Album*)self.detailItem).albumId,((Album*)self.detailItem).albumName];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end

//
//  HDSlideNavigationController.h
//  HelloiOS
//
//  Created by Yu Hongda on 13-10-6.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MIRROR_RATIO 0.9
#define MIRROR_ALPHA 0.5


typedef enum{
    LEFT,RIGHT
}AnimationDirection;

@interface HDSlideNavigationController : UINavigationController<UINavigationControllerDelegate>
{
    NSMutableArray* items;
    NSInteger currentIndex;
    UIImageView* mirrorView;
    CGRect mirrorRect;
    BOOL isPush;
}
-(UIImage *)generatePreviousViewPage;
@end

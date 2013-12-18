//
//  HDSlideNavigationController.m
//  HelloiOS
//
//  Created by Yu Hongda on 13-10-6.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import "HDSlideNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface HDSlideNavigationController ()

@end

@implementation HDSlideNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithRootViewController:(UIViewController *) rootViewController{
    items = [[NSMutableArray alloc]initWithCapacity:0];
    currentIndex = -1;
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        mirrorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * MIRROR_RATIO, self.view.frame.size.height*MIRROR_RATIO)];
        mirrorRect = mirrorView.bounds;
        mirrorView.center = self.view.center;
        mirrorView.alpha = MIRROR_ALPHA;
        
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.delegate = self;
        [self.view addGestureRecognizer:recognizer];
        
        self.delegate = self;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (currentIndex<=0) {
        UIView* background = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        background.backgroundColor = [UIColor blackColor];
        [background addSubview:mirrorView];
        [self.view.superview insertSubview:background belowSubview:self.view];
    }
    isPush = YES;
    currentIndex++;
    if (currentIndex>0) {
        [self generatePreviousViewPage];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    isPush = NO;
    currentIndex--;
    if (currentIndex<=0) {
        [mirrorView.superview removeFromSuperview];
    }
    return [super popViewControllerAnimated:animated];
}

-(UIImage *)generatePreviousViewPage{
    if (currentIndex >= 0) {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.view.layer renderInContext:context];
        __autoreleasing UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [items addObject:image];
        return image;
    }
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (isPush) {
//        [self generatePreviousViewPage];
        if (currentIndex>0) {
            [mirrorView setImage:[items objectAtIndex:currentIndex-1]];
        }
    }else{
        if (items.count > 0) {
            [items removeLastObject];
            if (currentIndex == 0) {
                [mirrorView setImage:nil];
            }else{
                [mirrorView setImage:[items objectAtIndex:currentIndex-1]];
            }
        }
    }
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
/*
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (items.count<=0) {
        return;
    }
    
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGPoint prevPoint = [touch previousLocationInView:self.view];
    double offset = point.x-prevPoint.x;
    if (self.view.frame.origin.x+offset>=0 && self.view.frame.origin.x+offset <= self.view.frame.size.width) {
        self.view.center = CGPointMake(self.view.center.x+offset, self.view.center.y);
        mirrorView.bounds = CGRectMake(0, 0, mirrorRect.size.width+(self.view.frame.origin.x/self.view.frame.size.width)*(1-MIRROR_RATIO)*mirrorRect.size.width, mirrorRect.size.height+(self.view.frame.origin.x/self.view.frame.size.width)*(1-MIRROR_RATIO)*mirrorRect.size.height);
        mirrorView.alpha = MIRROR_ALPHA+(self.view.frame.origin.x/self.view.frame.size.width)*(1-MIRROR_ALPHA);
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (items.count<=0) {
        return;
    }
    
    if (self.view.frame.origin.x >=self.view.frame.size.width/2) {
        [self slideAnimation:RIGHT];
    }else{
        [self slideAnimation:LEFT];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (items.count<=0) {
        return;
    }
    
    if (self.view.frame.origin.x >=self.view.frame.size.width/2) {
        [self slideAnimation:RIGHT];
    }else{
        [self slideAnimation:LEFT];
    }
}*/


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self.view];
    CGPoint velocity = [gestureRecognizer velocityInView:self.view];
    double angle = atan2(velocity.y, velocity.x) * 180.0f /3.14159f;
    
    if (fabs(angle) > 45 && fabs(angle) < 135) {
        NSLog(@"%@",@"up n' down");
    }else{
        
        if (items.count<=0) {
            return;
        }
        
        if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
            firstX = location.x;
            firstY = location.y;
        }
        
        CGFloat offsetX = location.x-firstX;
        if (self.view.frame.origin.x+offsetX>=0 && self.view.frame.origin.x+offsetX <= self.view.frame.size.width) {
            self.view.center = CGPointMake(self.view.center.x+offsetX, self.view.center.y);
            mirrorView.bounds = CGRectMake(0, 0, mirrorRect.size.width+(self.view.frame.origin.x/self.view.frame.size.width)*(1-MIRROR_RATIO)*mirrorRect.size.width, mirrorRect.size.height+(self.view.frame.origin.x/self.view.frame.size.width)*(1-MIRROR_RATIO)*mirrorRect.size.height);
            mirrorView.alpha = MIRROR_ALPHA+(self.view.frame.origin.x/self.view.frame.size.width)*(1-MIRROR_ALPHA);
        }
        
        
        
        if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
            if (items.count<=0) {
                return;
            }
            
            if (self.view.frame.origin.x >=self.view.frame.size.width/2) {
                [self slideAnimation:RIGHT];
            }else{
                [self slideAnimation:LEFT];
            }
        }
    }
}


-(void)slideAnimation:(AnimationDirection)direction{
    switch (direction) {
        case LEFT:{
            [self.view setUserInteractionEnabled:NO];
            [UIView animateWithDuration:0.5 animations:^{
                self.view.frame = CGRectMake(0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                mirrorView.bounds = CGRectMake(0, 0, mirrorRect.size.width, mirrorRect.size.height);
                mirrorView.alpha = MIRROR_ALPHA;
            } completion:^(BOOL finished){
                [self.view setUserInteractionEnabled:YES];
            }];
        }
            break;
        case RIGHT:{
            [self.view setUserInteractionEnabled:NO];
            [UIView animateWithDuration:0.5 animations:^{
                self.view.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                mirrorView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            }completion:^(BOOL finished) {
                if (finished) {
                    [self.view setUserInteractionEnabled:YES];
                    [self popViewControllerAnimated:NO];
                    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                }
            }];
        }
            break;
        default:
            break;
    }
}

-(void)dealloc{
    
    if (mirrorView.superview.superview) {
        [mirrorView.superview removeFromSuperview];
    }
    self.delegate = nil;
}

@end

//
//  TBPushTransition.m
//  MemoireTest
//
//  Created by Tom Bentz on 23/08/2015.
//  Copyright (c) 2015 Tom Bentz. All rights reserved.
//

#import "TBPushTransition.h"

@implementation TBPushTransition

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // init
    UIViewController *firstViewController = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *secondViewController = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    self.containerView = [transitionContext containerView];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    self.animatedViewsArray = [NSMutableArray new];
    
    
    secondViewController.view.frame = CGRectMake(secondViewController.view.frame.origin.x + secondViewController.view.frame.size.width, secondViewController.view.frame.origin.y, secondViewController.view.frame.size.width, secondViewController.view.frame.size.height);
    
    
    [self hideEndViews];
    
    [secondViewController.view layoutSubviews];
    [containerView addSubview:secondViewController.view];
    
    [self createAnimatedViewsArray];
    
    
    //animation
    [UIView animateWithDuration:duration animations:^{
        
        // animate view controllers
        firstViewController.view.frame = CGRectMake(-firstViewController.view.frame.size.width, firstViewController.view.frame.origin.y, firstViewController.view.frame.size.width, firstViewController.view.frame.size.height);
        
        secondViewController.view.frame = [transitionContext finalFrameForViewController:secondViewController];
        
        // animates views
        for (int i = 0; i < [self.delegate viewsToPushTo].count; i++)
        {
            CGRect frame = [containerView convertRect:((UIView *)[[self.delegate viewsToPushTo] objectAtIndex:i]).frame fromView:((UIView *)[[self.delegate viewsToPushTo] objectAtIndex:i]).superview];
            ((UIView *)[self.animatedViewsArray objectAtIndex:i]).frame = frame;
        }
        
    } completion:^(BOOL finished) {
        
        for (UIView *view in [self.delegate viewsToPushFrom])
        {
            [view setHidden:NO];
        }
        
        for (UIView *view in [self.delegate viewsToPushTo])
        {
            [view setHidden:NO];
        }
        
        for (UIView *view in self.animatedViewsArray)
        {
            [view removeFromSuperview];
        }
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)createAnimatedViewsArray
{
    for (UIView *view in [self.delegate viewsToPushFrom])
    {
        if ([view isKindOfClass:[UIImageView class]])
        {
            self.animatedView = [[UIImageView alloc] initWithImage:[(UIImageView *)view image]];
            self.animatedView.contentMode = view.contentMode;
            self.animatedView.alpha = view.alpha;//same view opacity
            self.animatedView.layer.opacity = view.layer.opacity;//same layer opacity
            self.animatedView.clipsToBounds = view.clipsToBounds;//same clipping settings
            self.animatedView.backgroundColor = view.backgroundColor;//same BG color
            self.animatedView.tintColor = view.tintColor;//matches tint color.
            self.animatedView.opaque = view.opaque;
        }
        else if ([view isKindOfClass:[UILabel class]])
        {
            self.animatedView = [[UILabel alloc] init];
            ((UILabel *)self.animatedView).text = ((UILabel *)view).text;
            ((UILabel *)self.animatedView).numberOfLines = ((UILabel *)view).numberOfLines;
			((UILabel *)self.animatedView).font = ((UILabel *)view).font;
			((UILabel *)self.animatedView).textColor = ((UILabel *)view).textColor;
			((UILabel *)self.animatedView).textAlignment = ((UILabel *)view).textAlignment;
        }
        else
        {
            self.animatedView = [view snapshotViewAfterScreenUpdates:NO];
        }
        
        self.animatedView.frame = [self.containerView convertRect:view.frame fromView:view.superview];
        [view setHidden:YES];
        [self.containerView addSubview:self.animatedView];
        [self.animatedViewsArray addObject:self.animatedView];
    }
}

- (void)hideEndViews
{
    for (UIView *view in [self.delegate viewsToPushTo])
    {
        [view setHidden:YES];
    }
}

@end

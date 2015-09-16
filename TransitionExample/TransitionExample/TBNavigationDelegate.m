//
//  TBNavigationDelegate.m
//  MemoireTest
//
//  Created by Tom Bentz on 05/09/2015.
//  Copyright (c) 2015 Tom Bentz. All rights reserved.
//

#import "TBNavigationDelegate.h"
#import "TBPushTransition.h"
#import "TBPopTransition.h"

@implementation TBNavigationDelegate

+ (instancetype)sharedInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush)
    {
        return [TBPushTransition sharedInstance];
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        return [TBPopTransition sharedInstance];
    }
    else
    {
        return nil;
    }
}

@end

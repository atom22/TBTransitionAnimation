//
//  TBPopTransition.h
//  MemoireTest
//
//  Created by Tom Bentz on 05/09/2015.
//  Copyright (c) 2015 Tom Bentz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TBPopViewControllerDelegate <NSObject>

- (NSArray *)viewsToPopFrom;
- (NSArray *)viewsToPopTo;

@end

@interface TBPopTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) UIView *animatedView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSMutableArray *animatedViewsArray;

+ (instancetype)sharedInstance;

@end

//
//  TBPushTransition.h
//  MemoireTest
//
//  Created by Tom Bentz on 23/08/2015.
//  Copyright (c) 2015 Tom Bentz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TBPushViewControllerDelegate <NSObject>

- (NSArray *)viewsToPushFrom;
- (NSArray *)viewsToPushTo;

@end

@interface TBPushTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) UIView *animatedView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSMutableArray *animatedViewsArray;

+ (instancetype)sharedInstance;

@end

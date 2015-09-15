//
//  TBNavigationDelegate.h
//  MemoireTest
//
//  Created by Tom Bentz on 05/09/2015.
//  Copyright (c) 2015 Tom Bentz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TBNavigationDelegate : NSObject <UINavigationControllerDelegate>

+ (instancetype)sharedInstance;

@end

//
//  SecondViewController.m
//  TransitionExample
//
//  Created by Tom Bentz on 15/09/2015.
//  Copyright (c) 2015 Tom Bentz. All rights reserved.
//

#import "SecondViewController.h"

#import "FirstViewController.h"
#import "TBPopTransition.h"

@interface SecondViewController () <TBPopViewControllerDelegate>

@end

@implementation SecondViewController
{
    FirstViewController *firstVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    firstVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [TBPopTransition sharedInstance].delegate = self;
}


#pragma mark - TBPopTransition Methods

- (NSArray *)viewsToPopFrom
{
    return @[self.alfaIV, self.helloLB];
}

- (NSArray *)viewsToPopTo
{
    return @[firstVC.alfaIV, firstVC.helloLB];
}

@end

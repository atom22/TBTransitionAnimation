//
//  FirstViewController.m
//  TransitionExample
//
//  Created by Tom Bentz on 15/09/2015.
//  Copyright (c) 2015 Tom Bentz. All rights reserved.
//

#import "FirstViewController.h"

#import "SecondViewController.h"
#import "TBPushTransition.h"

@interface FirstViewController () <TBPushViewControllerDelegate>

@end

@implementation FirstViewController
{
    SecondViewController *secondVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSecond)];
    [self.alfaIV addGestureRecognizer:tap];
    [self.alfaIV setUserInteractionEnabled:YES];
    
    [self.view setBackgroundColor:[UIColor cyanColor]];
    
    secondVC = [SecondViewController new];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [TBPushTransition sharedInstance].delegate = self;
}

- (void)goSecond
{
    [self.navigationController pushViewController:secondVC animated:YES];
}


#pragma mark - TBPushTransition Methods

- (NSArray *)viewsToPushFrom
{
    return @[self.alfaIV, self.helloLB];
}

- (NSArray *)viewsToPushTo
{
    return @[secondVC.alfaIV, secondVC.helloLB];
}

@end

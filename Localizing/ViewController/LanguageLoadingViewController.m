//
//  LanguageLoadingViewController.m
//  Localizing
//
//  Created by Jn.Huang on 2018/10/15.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "LanguageLoadingViewController.h"

@interface LanguageLoadingViewController ()

@end

@implementation LanguageLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

@end

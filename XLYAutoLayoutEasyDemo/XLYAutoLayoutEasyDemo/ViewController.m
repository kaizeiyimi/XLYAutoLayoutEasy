//
//  ViewController.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 16/4/22.
//  Copyright © 2016年 kaizei. All rights reserved.
//

#import "ViewController.h"

#import "XLYAutoLayoutEasy.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *container = [UIView new];
    container.backgroundColor = [UIColor grayColor];
    [self.view addSubview:container];
    
    UIView *v1 = [UIView new];
    v1.backgroundColor = [UIColor redColor];
    [container addSubview:v1];
    
    UIView *v2 = [UIView new];
    v2.backgroundColor = [UIColor orangeColor];
    [container addSubview:v2];
    
    for (UIView *v in @[container, v1, v2]) {
        v.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    [NSLayoutConstraint ale_makeWithDirection:NSLayoutFormatDirectionRightToLeft autoActive:YES construction:^{
        [container.ale_edge ale_equal:@[@50, @80, NSNull.null, @-40]];
        [container.ale_height ale_equal:@200];
        
        [v1.ale_size ale_equal: @[@40, @40]];
        v1.topAnchor.ale_equal(container.ale_top.ale_c(10));
        [v1.leadingAnchor ale_equal:container.leadingAnchor.ale_c(20)];
        
        [v2.ale_size ale_equal:@[@100, @40]];
        [@[v2.ale_leading, v2.ale_top] ale_equal:@[v1.ale_centerX, v1.ale_bottom.ale_c(10)]];
       
        
//        v1.ale_top.equal(v2.ale_top)
        
//        v1.topAnchor.ale.equal(v2.topAnchor.ale.c(50).p(750));
        
        v1.topAnchor.ale_equal(v2.topAnchor.ale_c(50).ale_p(750));
        
    }];
}

@end

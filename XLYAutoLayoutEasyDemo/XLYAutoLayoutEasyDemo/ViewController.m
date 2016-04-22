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
    
    [NSLayoutConstraint xly_makeWithDirection:NSLayoutFormatDirectionLeadingToTrailing autoActive:YES construction:^{
        container.xly_edge.xly_compositeEqual(@[@50, @40, NSNull.null, @-40]);
        container.xly_layoutAttribute(NSLayoutAttributeHeight).equal((@200));
        
        v1.xly_size.xly_compositeEqual(@[@50, @50]);
        
        @[v1.xly_layoutAttribute(NSLayoutAttributeLeading), v1.xly_layoutAttribute(NSLayoutAttributeTop)].xly_compositeEqual(@[@10, @20]);
        @[v2.xly_layoutAttribute(NSLayoutAttributeLeading), v2.xly_layoutAttribute(NSLayoutAttributeTop)].xly_compositeEqual(@[v1.xly_layoutAttribute(NSLayoutAttributeTrailing), v1.xly_layoutAttribute(NSLayoutAttributeBottom)]);
        v2.xly_size.xly_compositeEqual(v1.xly_size);
        
    }];
}

@end

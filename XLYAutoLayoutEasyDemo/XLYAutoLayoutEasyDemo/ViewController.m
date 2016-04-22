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
        container.ale_edge.ale_compositeEqual(@[@50, @40, NSNull.null, @-40]);
        [container.ale_edge ale_compositeEqual:@[@50, @80, NSNull.null, @-40]];
        
        container.ale_layoutAttribute(NSLayoutAttributeHeight).ale_equal((@200));
        
//        v1.ale_size.ale_compositeEqual(@[@50, @50]);
        
        v1.topAnchor.ale_equal(container.topAnchor);
        [v1.topAnchor ale_equal:container.topAnchor];
//        
//        @[v1.ale_layoutAttribute(NSLayoutAttributeLeading), v1.ale_layoutAttribute(NSLayoutAttributeTop)].ale_compositeEqual(@[@10, @20]);
//        @[v2.ale_layoutAttribute(NSLayoutAttributeLeading), v2.ale_layoutAttribute(NSLayoutAttributeTop)].ale_compositeEqual(@[v1.ale_layoutAttribute(NSLayoutAttributeTrailing), v1.ale_layoutAttribute(NSLayoutAttributeBottom)]);
//        v2.ale_size.ale_compositeEqual(v1.ale_size);
        
    }];
}

@end

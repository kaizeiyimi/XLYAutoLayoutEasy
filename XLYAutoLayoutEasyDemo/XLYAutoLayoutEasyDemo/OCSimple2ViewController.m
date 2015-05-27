//
//  OCSimple2ViewController.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 15/5/24.
//  Copyright (c) 2015年 kaizei. All rights reserved.
//

#import "OCSimple2ViewController.h"

#import "XLYAutoLayoutEasy.h"

@interface OCSimple2ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *purpleView;

@end

@implementation OCSimple2ViewController

- (void)loadView {
  [super loadView];
  self.imageView = [UIImageView new];
  self.imageView.backgroundColor = [UIColor blueColor];
  
  self.titleLabel = [UILabel new];
  self.titleLabel.text = @"this is a test title";
  self.titleLabel.font = [UIFont systemFontOfSize:17];
  self.titleLabel.numberOfLines = 2;
  self.titleLabel.textColor = [UIColor blackColor];
  
  self.contentLabel = [UILabel new];
  self.contentLabel.text = @"this is a test content, this is a test content, this is a test content, this is a test content, this is a test content";
  self.contentLabel.font = [UIFont systemFontOfSize:12];
  self.contentLabel.numberOfLines = 3;
  self.contentLabel.textColor = [UIColor grayColor];

  self.centerView = [UIView new];
  self.centerView.backgroundColor = [UIColor greenColor];
  
  self.purpleView = [UIView new];
  self.purpleView.backgroundColor = [UIColor purpleColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  for( UIView *subView in @[_imageView, _titleLabel, _contentLabel, _centerView, _purpleView]) {
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subView];
  }
  
  [self setupConstraintsUsingCompositeStyle];
//  [self setupConstraintsUsingNormalStyle];
}

- (void)setupConstraintsUsingCompositeStyle {
  // use composite constraints, size, center, edge.
  [NSLayoutConstraint xly_makeWithDirection:NSLayoutFormatDirectionLeadingToTrailing constraints:^{
    
    [self.imageView.xly_size equalToCGSize:CGSizeMake(60, 60)];
    [self.imageView.xly_edge equalToTop:self.xly_topGuideView.xly_bottom.constant(10) leading:@10 bottom:nil trailing:nil];
    
    [self.titleLabel.xly_edge equalToTop:self.imageView
                                 leading:self.imageView.xly_trailing.constant(10)
                                  bottom:nil
                                trailing:self.view.xly_trailing.constant(-10)];
    
    [self.contentLabel.xly_edge equalToTop:self.titleLabel.xly_bottom.constant(10)
                                   leading:self.titleLabel
                                    bottom:nil
                                  trailing:self.titleLabel];
    
    [self.centerView.xly_size equalTo:self.titleLabel offset:UIOffsetMake(0, 20)];
    [self.centerView.xly_center equalToCenterX:self.contentLabel.xly_centerX.constant(10) centerY:self.view];
    
    [NSLayoutConstraint xly_makeWithDirection:NSLayoutFormatDirectionRightToLeft constraints:^{
      [self.purpleView.xly_edge equalTo:self.centerView insets:UIEdgeInsetsMake(5, 20, 5, 5)];
    }];
  }];
}


- (void)setupConstraintsUsingNormalStyle {
  // use normal XLYConstraint
  [NSLayoutConstraint xly_makeWithDirection:NSLayoutFormatDirectionLeadingToTrailing constraints:^{
    [self.imageView.xly_width equalToConstant:60];
    [self.imageView.xly_height equalToConstant:60];
    [self.imageView.xly_top equalTo:self.xly_topGuideView.xly_bottom.constant(10)];
    [self.imageView.xly_leading equalToConstant:10];
    
    [self.titleLabel.xly_top equalTo:self.imageView];
    [self.titleLabel.xly_leading equalTo:self.imageView.xly_trailing.constant(10)];
    [self.titleLabel.xly_trailing equalTo:self.view.xly_trailing.constant(-10)];
    
    [self.contentLabel.xly_leading equalTo:self.titleLabel];
    [self.contentLabel.xly_top equalTo:self.titleLabel.xly_bottom.constant(10)];
    [self.contentLabel.xly_trailing equalTo:self.titleLabel];
    
    [self.centerView.xly_centerX equalTo:self.contentLabel.xly_centerX.constant(10)];
    [self.centerView.xly_centerY equalTo:self.view];
    [self.centerView.xly_width equalTo:self.titleLabel];
    [self.centerView.xly_height equalTo:self.titleLabel.xly_height.constant(20)];
    
    [NSLayoutConstraint xly_makeWithDirection:NSLayoutFormatDirectionRightToLeft constraints:^{
      [self.purpleView.xly_top equalTo:self.centerView.xly_top.constant(5)];
      [self.purpleView.xly_leading equalTo:self.centerView.xly_leading.constant(20)];
      [self.purpleView.xly_bottom equalTo:self.centerView.xly_bottom.constant(-5)];
      [self.purpleView.xly_trailing equalTo:self.centerView.xly_trailing.constant(-5)];
    }];
  }];
}

@end

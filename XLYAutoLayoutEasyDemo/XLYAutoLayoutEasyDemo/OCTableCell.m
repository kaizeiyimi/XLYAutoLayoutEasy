//
//  OCTableCell.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 15/5/16.
//  Copyright (c) 2015年 kaizei. All rights reserved.
//

#import "OCTableCell.h"

#import "XLYAutoLayoutEasy.h"


@interface OCTableCell ()

@property (nonatomic, weak) IBOutlet UIImageView *firstImageView;
@property (nonatomic, weak) IBOutlet UIView *customView;
@property (nonatomic, weak) IBOutlet UILabel *secondLabel;

@end

@implementation OCTableCell

- (void)prepareForReuse {
  [super prepareForReuse];
  
  // perform update constraints here just for demo.
  [NSLayoutConstraint xly_update:^{
    // perform update, change the imageView's frame.
    // thease code shows the ability to operation constraints created in IB.
//    self.firstImageView.xly_leading.equalToConstant(8);   // origin value is 15
//    self.firstImageView.xly_top.equalToConstant(8);   // origin value is 15
    
    [self.firstImageView.xly_edge equalToTop:@8 leading:@8 bottom:nil trailing:nil]; // origin is 15 top and 15 leading
    [self.firstImageView.xly_size equalToCGSize:CGSizeMake(50, 30)]; // origin is 120 width and 120 height
    
    [self.customView.xly_height equalToConstant:30]; // origin is 60 height
  }];
}

@end

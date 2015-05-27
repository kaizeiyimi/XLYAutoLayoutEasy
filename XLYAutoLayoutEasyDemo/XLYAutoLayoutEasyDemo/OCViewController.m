//
//  OCViewController.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 15/5/16.
//  Copyright (c) 2015年 kaizei. All rights reserved.
//

#import "OCViewController.h"

@interface OCViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation OCViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  return cell;
}

@end

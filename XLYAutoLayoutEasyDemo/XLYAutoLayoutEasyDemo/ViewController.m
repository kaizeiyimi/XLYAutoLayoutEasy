//
//  ViewController.m
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 14/11/18.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

#import "ViewController.h"

#import "XLYAutoLayoutEasy.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *label;

@property (nonatomic, weak) UIView *testView;
@property (nonatomic, strong) NSLayoutConstraint *constraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // add a blue test view.
    UIView *testView = [UIView new];
    testView.translatesAutoresizingMaskIntoConstraints = NO;
    testView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testView];
    self.testView = testView;
    [self make];
}

- (IBAction)selectionChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self update];
            break;
        case 1:
            [self remake];
            break;
        default:
            break;
    }
}

- (void)make
{
    //make, update, remake methods will return the created constraints.
    __unused NSArray *constraints = [UIView makeConstraints:^{
        self.testView.layoutTop.equalTo(self.topLayoutGuideView.layoutBottom).offset(@200); //vertical space to the topLayoutGuide's bottom
        self.testView.layoutTrailing.equalTo(self.view).offset(@-100); // default to self.view.layoutTrailing
        self.testView.layoutLeading.equalTo(@100); //default to superview's layoutLeading
        self.testView.layoutHeight.equalTo(self.label).priority(UILayoutPriorityDefaultHigh); // default to label's layoutHeight
    }];
}

- (void)update
{
    static BOOL change = YES;
    CGFloat metric = change ? 80 : 120;
    //you can just write a similar layout to update. no constraint refrence needed.
    [UIView updateConstraints:^{
        self.testView.layoutLeading.equalTo(self.view).offset(@(metric));
        
        //the top constraint is created in storyboard, and can be updated in this block.
        self.label.layoutTop.equalTo(self.topLayoutGuideView.layoutBottom).offset(@(metric));
    }];
    change = !change;
    
    //each time we remake the constraints, we record the refrence to self.constraint.
    //you can also use the code below to perform update. if you do so, you must also create a variable to record the constraint.
    //use [UIView updateConstraint:], no constraint variable is needed. we seek it for you.
    
//    self.constraint.constant = metric;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)remake
{
    static BOOL change = YES;
    CGFloat metric = change ? 80 : 120;
    [UIView animateWithDuration:0.5 animations:^{
        [UIView remakeConstraints:^{
            self.testView.layoutTop.equalTo(self.topLayoutGuideView.layoutBottom).offset(@(metric + 120));
            self.testView.layoutTrailing.equalTo(self.view).offset(@(-metric));
            //here we can get the resultConstraint, and can be modified later
            self.constraint = self.testView.layoutLeading.equalTo(@(metric)).resultConstraint;
            self.testView.layoutHeight.equalTo(@(metric));
            change = !change;
        }];
        [self.view layoutIfNeeded];
    }];
}

@end

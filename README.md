## upgraded to 2.0! ##
added new feature for **direction** handling, refactored all APIs prefixed with **xly_** and some more. 

### XCode 6.3 and above ###
uses nullabity annotation in public headers(mainly for swift), so you sould use xcode 6.3 and above.
see [apple's swift blog](https://developer.apple.com/swift/blog/?id=25) for detail.

### Quick look ###

```objective-c
//objective-c code

// import "XLYAutoLayoutEasy.h"

//make constraints. Put code in the block, the constraints will auto active.
// default uses NSLayoutFormatOptions.DirectionLeadingToTrailing
[NSLayoutConstraint xly_make:^{
  // set width equal to (titleLabel's height), height equal to 60
  [self.imageView.xly_width equalToConstant:self.titleLabel.xly_height];
  [self.imageView.xly_height equalToConstant:60];
  // you can use composite format
  [self.imageView.xly_size equalToWidth:self.titleLabel.xly_height height:@60];
  
  // if width and height are all numbers, you can use CGSize format 
  [self.imageView.xly_size equalToCGSize:CGSizeMake(60, 60)];
}];

// we also support center and edge composite constraints. see API for more detail.

//update
- (void)updateConstraints {
  const CGFloat margin = 8;
  
  // these codes show a recommended place to use updateConstraints. 'update' will auto find the 'similiar' constraint, disable it and active new one.
  [NSLayoutConstraint xly_update:^{
    [_leftView.xly_edge equalToTop:@(margin) leading:@(margin) bottom:@(-margin) trailing:nil];
    [_leftView.xly_width equalTo:self.xly_width.multiplier(0.5).constant(-1.5 * margin)];

    [_rightView.xly_edge equalToTop:_leftView leading:_leftView.xly_trailing.constant(margin) bottom:_leftView trailing:@(-margin)];
  }];
  [super updateConstraints];
}

```

```swift
//swift code

// import "XLYAutoLayoutEasy-swift.h"

// It's almost the same as OC style.
// default uses NSLayoutFormatOptions.DirectionLeadingToTrailing
NSLayoutConstraint.xly_make {
  self.centerView.xly_size.equalTo(self.titleLabel, offset: UIOffset(horizontal: 0, vertical: 20))
  self.centerView.xly_center.equalToCenterX(self.contentLabel.xly_centerX.constant(10), centerY: self.view)
  
  // use right-to-left to make leading and trailing to be right and left. 
  NSLayoutConstraint.xly_makeWithDirection(NSLayoutFormatOptions.DirectionRightToLeft) {
    self.purpleView.xly_edge.equalTo(self.centerView, insets: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 5))
  }
}
```

It's easy to read and write. isn't it?

swift compiler has a bug that `UILayoutPriority` variables cannot appear in code or else the compilation fails. so currently we developer must use 750 to replace `UILayoutPriorityDefaultHigh`.

###work with other constraints###

unlike some other lib, my lib **can work together** with constraints you created in any other way, for example, constraints created from storyboard or xib or even the VFL or the previous API have no difference with the constraints created in **+[UIView xly_makeConstraint:]**, and can be searched in **update**. All I do is simplify the creation of constraint.

### How to use ###

pod 'XLYAutoLayoutEasy', '~> 2.0.0'.

import  `"XLYAutoLayoutEasy.h"` where you want to use it. 
If you use swift please import `"XLYAutoLayoutEasy-swift.h"` in your bridge header instead. 

* use `+[NSLayoutConstraint xly_make:]` to create and active constraints. 
* use `+[NSLayoutConstraint xly_update:]` to find an existing similar constraint, remove it and active the new ones, or create and active the new ones if no similar found. 

* xly_XX* properties such as xly_height or xly_leading are to describe a view and a `NSLayoutAttribute` attribute.

* all params expecting 'id' can be *ViewAttribute*(normal or composite), *UIView* or 'Number'. *ViewAttribute* specifies a view and a NSLayoutAttribute. UIView specifies only a view, and the NSLayoutAttribute will be the same as firstItem's layout attribute. 'Number' will specify firstItem's superView with same layout attribute and has a constant of the number's value (height and width will set secondItem to nil and secondAttribute to NSLayoutAttributeNotAnAttribute).

see the demo or source code for more details. The codes are easy to be understood and use.

### What's *the matter* of AutoLayout ? ###

* The API is not friendly for developers. at least I think so.

you can use 
`
+[NSLayoutConstraint constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:]
`
to create a constraint and then modify the priority if needed. after you create a constraint, it's your responsibility to find the appropriate view to add the constraint. the view to add the constraint must be a **common superview** of the firstItem and secondItem of constraint. the API is too long and finding the common superview is boring.

or you can use VFL to create constraints. sounds good, but more problems appears. you still have to find the common superview (though, somebody will just use the viewController.view), and you will have problem to get a specified constraint in the returned array. 

### What I simplified ###

briefly, I make this lib trying to make the `autolayout` code writing more easily. but to what degree should I simplify? after my thinking, currently I only simplify the `+[NSLayoutConstraint constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:]` API. provide **make**, **update**  functions to help create, active and modify constraints.

Now, I also added **size**, **center** and **edge** composite constraints to make code more simple and understandable.


### Quick look ###

```objective-c
//objective-c code

// import "XLYAutoLayoutEasy.h"

//make constraints
[UIView makeConstraints:^{
    testView.layoutTop.equalTo(self.topLayoutGuideView.layoutBottom).constant(50);
    testView.layoutTrailing.equalTo(self.view).constant(-50);
    testView.layoutLeading.equalToConstant(50);
    testView.layoutHeight.equalToConstant(100);
}];

//update
[UIView updateConstraints:^{
    self.testView.layoutLeading.equalTo(self.view).constant(metric);

        //the top constraint is created in storyboard, and can be updated in this block.
    self.label.layoutTop.equalTo(self.topLayoutGuideView.layoutBottom).constant(metric);
}];

//remake, all the constraint associated with testView will be removed before the new constraints being active.
[UIView remakeConstraints:^{
    self.testView.layoutTop.equalTo(self.topLayoutGuideView.layoutBottom).constant(metric + 120);
    self.testView.layoutTrailing.equalTo(self.view).constant(-metric);

        //here we can get the resultConstraint, and can be modified later
    self.constraint = self.testView.layoutLeading.equalToConstant(metric).resultConstraint;
    self.testView.layoutHeight.equalToConstant(metric);
}];
```

```swift
//swift code

// import "XLYAutoLayoutEasy-swift.h"

UIView.makeConstraints {
view.layoutTop.equalTo(self.topLayoutGuideView.layoutBottom).constant(100)
view.layoutLeading.equalTo(self.view).constant(50)
view.layoutTrailing.equalTo(self.view).constant(-50)
view.layoutHeight.equalTo(100).priority(750)
}
```
It's easy to read and write. isn't it?

swift compiler has a bug that `UILayoutPriority` variables cannot appear in code or else the compilation fails. so currently we developer must use 750 to replace `UILayoutPriorityDefaultHigh`.

###work with other constraints###

unlike some other lib, my lib **can work together** with constraints you created not in my way, for example, constraints created from storyboard or xib or even the VFL or the previous API have no difference with the constraints created in **+[UIView makeConstraint:]**, and can be searched in **update** or **remake**.

### How to use ###

currently I haven't make a pod. so just add codes to your project and then import `"XLYAutoLayoutEasy.h"` where you want to use it. If you use swift please import `"XLYAutoLayoutEasy-swift.h"` in your bridge header instead. 

* use `+[UIView makeConstraint:]` to create and active constraints. 
* use `+[UIView updateConstraints:]` to find an existing similar constraint and update it, or create and active the constraints if no similar ones found. 
* use `+[UIView remakeConstraints:]` to first remove constraints associated with views you used in the block, and then create and active constraints.
* layoutXX properties such as layoutHeight or layoutLeading are to describe the view and a `NSLayoutAttribute` attribute.

see the demo or source code for more details. my codes are easy to be understood and use.

### What's *the matter* of AutoLayout ? ###

* The API is not friendly for developers in iOS6 and iOS7. at least I think so.

you can use 
`
+[NSLayoutConstraint constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:]
`
to create a constraint and then modify the priority if needed. after you create a constraint, it's your responsibility to find the appropriate view to add the constraint. the view to add the constraint must be a **common superview** of the firstItem and secondItem of constraint. the API is too long and finding the common superview is boring.

or you can use VFL to create constraints. sounds good, but more problems appears. you still have to find the common superview (though, somebody will just use the viewController.view), and you will have problem to get a specified constraint in the returned array.

updating and remaking constraints are error-prone, usually you have to record the constraint or remove all of them before remaking. sounds not good.

### What I simplified ###

briefly, I make this lib trying to make the `autolayout` code writing more easily. but to what degree should I simplify? after my thinking, currently I only simplify the `+[NSLayoutConstraint constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:]` API. provide **make**, **update** and **remake** functions to help create, active, modify, and remove constraints.

maybe I will add *"equalTo size or point"*, maybe not. for now, **XLYAutoLayoutEasy** is powerful enough.

//
//  SwiftViewController.swift
//  XLYAutoLayoutEasyDemo
//
//  Created by kaizei on 15/5/16.
//  Copyright (c) 2015年 kaizei. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {
  
  let imageView = UIImageView()
  let titleLabel = UILabel()
  let contentLabel = UILabel()
  let centerView = UIView()
  let purpleView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NSLayoutConstraint.xly_setReplaceDescription()
    for subView in [imageView, titleLabel, contentLabel, centerView, purpleView] {
      subView.setTranslatesAutoresizingMaskIntoConstraints(false)
      self.view.addSubview(subView)
    }
    
    imageView.backgroundColor = UIColor.redColor()
    imageView.xly_debugName = "avatar";
    
    titleLabel.text = "this is a test title"
    titleLabel.font = UIFont.systemFontOfSize(17)
    titleLabel.numberOfLines = 2
    titleLabel.textColor = UIColor.blackColor()
    
    contentLabel.text = "this is a test content, this is a test content, this is a test content, this is a test content, this is a test content"
    contentLabel.font = UIFont.systemFontOfSize(12)
    contentLabel.numberOfLines = 3
    contentLabel.textColor = UIColor.grayColor()
    
    centerView.backgroundColor = UIColor.greenColor()
    
    purpleView.backgroundColor = UIColor.purpleColor()  // NOT a subview of centerView
    
    setupConstraintsUsingCompositeStyle()
//    setupConstraintsUsingNormalStyle()
//    setupConstraintsUsingAppleStyle()
  }
  
  func setupConstraintsUsingCompositeStyle() {
    // use composite constraints, size, center, edge.
    NSLayoutConstraint.xly_makeWithDirection(NSLayoutFormatOptions.DirectionLeadingToTrailing) {
      self.imageView.xly_size.equalToCGSize(CGSize(width: 60, height: 60))
      self.imageView.xly_edge.equalToTop(self.xly_topGuideView.xly_bottom.constant(10), leading: 10, bottom: nil, trailing: nil)
      
      self.titleLabel.xly_edge.equalToTop(self.imageView, leading: self.imageView.xly_trailing.constant(10), bottom: nil, trailing: self.view.xly_trailing.constant(-10))
      
      self.contentLabel.xly_edge.equalToTop(self.titleLabel.xly_bottom.constant(10), leading: self.titleLabel, bottom: nil, trailing: self.titleLabel)
      
      self.centerView.xly_size.equalTo(self.titleLabel, offset: UIOffset(horizontal: 0, vertical: 20))
      self.centerView.xly_center.equalToCenterX(self.contentLabel.xly_centerX.constant(10), centerY: self.view)
      
      NSLayoutConstraint.xly_makeWithDirection(NSLayoutFormatOptions.DirectionRightToLeft) {
        self.purpleView.xly_edge.equalTo(self.centerView, insets: UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 5))
      }
    }
  }
  
    
  func setupConstraintsUsingNormalStyle() {
    // use normal XLYConstraint
    NSLayoutConstraint.xly_make {
      self.imageView.xly_width.equalTo(60)
      self.imageView.xly_height.equalTo(60)
      self.imageView.xly_top.equalTo(self.xly_topGuideView.xly_bottom.constant(10))
      self.imageView.xly_leading.equalTo(10)

      self.titleLabel.xly_top.equalTo(self.imageView)
      self.titleLabel.xly_leading.equalTo(self.imageView.xly_trailing.constant(10))
      self.titleLabel.xly_trailing.equalTo(self.view.xly_trailing.constant(-10))
      
      self.contentLabel.xly_leading.equalTo(self.titleLabel)
      self.contentLabel.xly_top.equalTo(self.titleLabel.xly_bottom.constant(10))
      self.contentLabel.xly_trailing.equalTo(self.titleLabel)
      
      self.centerView.xly_centerX.equalTo(self.contentLabel.xly_centerX.constant(10))
      self.centerView.xly_centerY.equalTo(self.view)
      self.centerView.xly_width.equalTo(self.titleLabel)
      self.centerView.xly_height.equalTo(self.titleLabel.xly_height.constant(20))
      
      NSLayoutConstraint.xly_makeWithDirection(NSLayoutFormatOptions.DirectionRightToLeft) {
        self.purpleView.xly_top.equalTo(self.centerView.xly_top.constant(5))
        self.purpleView.xly_leading.equalTo(self.centerView.xly_leading.constant(20))
        self.purpleView.xly_bottom.equalTo(self.centerView.xly_bottom.constant(-5))
        self.purpleView.xly_trailing.equalTo(self.centerView.xly_trailing.constant(-5))
      }
    }
  }
  
  
  func setupConstraintsUsingAppleStyle() {
    // apple style, ios8 and above. very hard to read and write.
    
    let views: [NSObject : AnyObject] = ["topLayoutGuide":self.topLayoutGuide, "imageView":imageView, "titleLabel":titleLabel, "contentLabel":contentLabel, "centerView":centerView, "purpleView":purpleView]
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[imageView(60)]-10-[titleLabel]-10-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing | NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-10-[imageView(60)]", options:NSLayoutFormatOptions(0), metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[titleLabel]-10-[contentLabel]", options:NSLayoutFormatOptions.AlignAllLeading | NSLayoutFormatOptions.AlignAllTrailing, metrics: nil, views: views))
    
    NSLayoutConstraint(item: self.centerView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.contentLabel, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 10).active = true
    NSLayoutConstraint(item: self.centerView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0).active = true
    
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[centerView(titleLabel)]", options:NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: views))
    NSLayoutConstraint(item: self.centerView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.titleLabel, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 20).active = true

    NSLayoutConstraint.init(item: self.purpleView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.centerView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5).active = true
    NSLayoutConstraint.init(item: self.purpleView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.centerView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 5).active = true
    NSLayoutConstraint.init(item: self.purpleView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.centerView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5).active = true
    NSLayoutConstraint.init(item: self.purpleView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.centerView, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: -20).active = true
  }
}

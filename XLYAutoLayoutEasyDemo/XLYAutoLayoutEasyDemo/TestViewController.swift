//
//  SwiftViewController.swift
//  XLYAutoLayoutEasyDemo
//
//  Created by 王凯 on 14/11/25.
//  Copyright (c) 2014年 kaizei. All rights reserved.
//

import UIKit

/**
* there is a swift bug that UILayoutPriority cannot be directly uesed. it will cause complier fail.
* so I just use magic number.
*/

class SwiftViewController: UIViewController {
    
    var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView.init()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = UIColor.redColor()
        self.view.addSubview(view)
        testView = view
        UIView.makeConstraints {
            view.layoutTop.equalTo(self.topLayoutGuideView.layoutBottom).constant(100)
            view.layoutLeading.equalTo(self.view).constant(50)
            view.layoutTrailing.equalTo(self.view).constant(-50)
            // the priority of height is 750, change1 and change2 function will not modify this constraint but add a new constraint with 1000 priority. so after change function called, testView will have two height constraint, one's priority is 750 and another is 1000.
            view.layoutHeight.equalTo(100).priority(750)
        }
    }
    
    @IBAction func change1(sender: UIButton) {
        let button1 = self.view.viewWithTag(10)!
        UIView.animateWithDuration(0.5){
            UIView.updateConstraints {
                button1.layoutWidth.equalTo(80)
                self.testView.layoutHeight.equalTo(50)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func change2(sender: AnyObject) {
        let button1 = self.view.viewWithTag(10)!
        UIView.animateWithDuration(0.5){
            UIView.updateConstraints {
                button1.layoutWidth.equalTo(120)
                self.testView.layoutHeight.equalTo(200)
            }
            self.view.layoutIfNeeded()
        }
    }
    
}

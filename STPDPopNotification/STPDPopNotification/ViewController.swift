//
//  ViewController.swift
//  STPDPopNotification
//
//  Created by Chen Hao on 16/5/19.
//  Copyright © 2016年 Chen Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func stringNoDetail(sender: UIButton) {
        STPDPopNotification.popStringNotification("No Detail", content: nil)
    }
    
    @IBAction func stringWithDetail(sender: UIButton) {
        STPDPopNotification.popStringNotificationWithButton("With Detail [Two Buttons]", content: midContent, leftButtonTitle: "Cancel", leftButtonHandler: nil, rightButtonTitle: "OK") { (rightButton) in
            rightButton.addTarget(self, action: #selector(self.popNew(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func popNew(sender: UIButton) {
        STPDPopNotification.popStringNotificationWithButton("Two Buttons", content: nil, leftButtonTitle: "Cancel", leftButtonHandler: nil, rightButtonTitle: "OK", rightButtonHandler: nil)
    }
    

    @IBAction func stringExtraLong(sender: UIButton) {
        STPDPopNotification.popStringNotification("Long Detail", content: longContent)
    }
    
    @IBAction func regularImage(sender: UIButton) {
        STPDPopNotification.popImageNotification("Regular", imageFile: UIImage(named: "small"))
    }
    
    @IBAction func etraLongImage(sender: UIButton) {
        STPDPopNotification.popImageNotificationWithButton("Extra Long", imageFile: UIImage(named: "ultraLong"), leftButtonTitle: "Cancel", leftButtonHandler: nil, rightButtonTitle: "Load Regular") { (rightButton) in
            rightButton.addTarget(self, action: #selector(self.popNewImage(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func popNewImage(sender: UIButton) {
        STPDPopNotification.popImageNotificationWithButton("Two Buttons", imageFile: UIImage(named: "small"), leftButtonTitle: "Cancel", leftButtonHandler: nil, rightButtonTitle: "Ok", rightButtonHandler: nil)
    }

}

let midContent = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and apps run lightning-fast. Swift is ready for your next project — or addition into your current app — because Swift code works side-by-side with Objective-C. "

let longContent = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and apps run lightning-fast. Swift is ready for your next project — or addition into your current app — because Swift code works side-by-side with Objective-C. \n\nSwift has been refined from the ground up. It generates faster code across the board, both for release and debug builds. The Swift compiler is also faster, even while adding new Fix-it suggestions such as where you can use let instead of var. Comments can include Markdown syntax to add rich text and embedded images that display in Xcode’s Quick Help. A new assistant shows your Swift API in a “header-like” view. And new syntax features combined with improvements to the Cocoa frameworks and Objective-C will make your code more expressive, and even safer. \n\nYou can create an entirely new application with Swift today, or begin using Swift code to implement new features in your app, or enhance existing ones. Swift code co-exists along side your existing Objective-C files in the same project, with full access to your Objective-C API, making it easy to adopt."
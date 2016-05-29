//
//  STPDPopNotification.swift
//  STPDPopNotification
//
//  Created by Chen Hao on 16/5/19.
//  Copyright © 2016年 Chen Hao. All rights reserved.
//

import UIKit
import Foundation

class STPDPopNotification: NSObject {
    
    // MARK: - Public Functions
    
    static func popStringNotification(text: String, content: String?) {
        popStringNotification(text, content: content) { (baseView) in
            baseView.center.y -= UIScreen.mainScreen().bounds.height
            UIView.animateWithDuration(0.18, animations: {
                baseView.center.y += UIScreen.mainScreen().bounds.height
                }, completion: { (Bool) in
                    baseView.STPDAMRotate(0.1)
            })
        }
    }
    
    static func popStringNotificationWithButton(text: String, content: String?, leftButtonTitle: String, leftButtonHandler: ((leftButton: UIButton)->())?, rightButtonTitle: String, rightButtonHandler: ((rightButton: UIButton)->())?) {
        
        popStringNotificationButtonHandler(text, content: content, completionHandler: { (baseView) in
            baseView.center.y -= UIScreen.mainScreen().bounds.height
            UIView.animateWithDuration(0.18, animations: {
                baseView.center.y += UIScreen.mainScreen().bounds.height
                }, completion: { (Bool) in
                    baseView.STPDAMRotate(0.1)
            })
            }, leftButtonTitle: leftButtonTitle, leftButtonHandler: { (leftButton) in
                if leftButtonHandler != nil {
                    leftButtonHandler!(leftButton: leftButton)
                }
        }, rightButtonTitle: rightButtonTitle) { (rightButton) in
            if rightButtonHandler != nil {
                rightButtonHandler!(rightButton: rightButton)
            }
        }
    }
    
    static func popImageNotification(text: String, imageFile: UIImage?) {
        imageNotification(text, imageFile: imageFile) { (baseView) in
            baseView.center.y -= UIScreen.mainScreen().bounds.height
            UIView.animateWithDuration(0.18, animations: {
                baseView.center.y += UIScreen.mainScreen().bounds.height
                }, completion: { (Bool) in
                    baseView.STPDAMRotate(0.1)
            })
        }
    }
    
    static func popImageNotificationWithButton(text: String, imageFile: UIImage?, leftButtonTitle: String, leftButtonHandler: ((leftButton: UIButton)->())?, rightButtonTitle: String, rightButtonHandler: ((rightButton: UIButton)->())?) {
        
        imageNotificationButtonHandler(text, imageFile: imageFile, completionHandler: { (baseView) in
            baseView.center.y -= UIScreen.mainScreen().bounds.height
            UIView.animateWithDuration(0.18, animations: {
                baseView.center.y += UIScreen.mainScreen().bounds.height
                }, completion: { (Bool) in
                    baseView.STPDAMRotate(0.1)
            })
            }, leftButtonTitle: leftButtonTitle, leftButtonHandler: { (leftButton) in
                if leftButtonHandler != nil {
                    leftButtonHandler!(leftButton: leftButton)
                }
        }, rightButtonTitle: rightButtonTitle) { (rightButton) in
            if rightButtonHandler != nil {
                rightButtonHandler!(rightButton: rightButton)
            }
        }
    }
    
    static func clearAllNotification() {
        clear()
    }
    
    // MARK: - Private
    
    private static var windows = Array<UIWindow!>()
    private static let referenceView = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView?
    
    private struct constants {
        static let distanceToLeft: CGFloat = 40
        static let distanceToTop: CGFloat = 40
        static let cornorRadius: CGFloat = 10
        static let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)

        static let distanceBetweenElements: CGFloat = 8

        static let titleHeight: CGFloat = 36
        static let titleFontSize: CGFloat = 20
        
        static let buttonHeight: CGFloat = 36
        static let buttonFontSize: CGFloat = 17
        static let buttonornorRadius: CGFloat = 4
        static let buttonColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        static let contentFontSize: CGFloat = 16
        static let contentMaxHeightForCentralAlignment: CGFloat = 200
    }
    
    private static func popStringNotification(text: String, content: String?, completionHandler: (baseView: UIView)->()) {
        
        let window = UIWindow()
        let mainView = UIView()
        
        window.bounds = UIScreen.mainScreen().bounds
        mainView.layer.cornerRadius = constants.cornorRadius
        mainView.clipsToBounds = true
        mainView.backgroundColor = UIColor.clearColor()
        
        window.frame = CGRectMake(0, 0, window.bounds.width, window.bounds.height)
        mainView.frame = CGRectMake(constants.distanceToLeft, constants.distanceToTop, window.bounds.width - 2 * constants.distanceToLeft, window.bounds.height - 2 * constants.distanceToTop)
        
        let blurEff = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEff)
        blurView.frame = CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.width)
        blurView.layer.cornerRadius = constants.cornorRadius
        blurView.clipsToBounds = true
        mainView.addSubview(blurView)
        
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.numberOfLines = 0
        if #available(iOS 8.2, *) {
            titleLabel.font = UIFont.systemFontOfSize(constants.titleFontSize, weight: UIFontWeightRegular)
        } else {
            titleLabel.font = UIFont.systemFontOfSize(constants.titleFontSize)
        }
        
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.frame = CGRectMake(constants.distanceBetweenElements, constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.titleHeight)
        mainView.addSubview(titleLabel)
        
        let okButton = UIButton()
        okButton.setTitle("Ok", forState: .Normal)
        if #available(iOS 8.2, *) {
            okButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize, weight: UIFontWeightLight)
        } else {
            okButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize)
        }
        
        okButton.backgroundColor = constants.buttonColor
        
        okButton.layer.cornerRadius = constants.buttonornorRadius
        okButton.clipsToBounds = true
        
        okButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        okButton.frame = CGRectMake(constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.buttonHeight - constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.buttonHeight)
        mainView.addSubview(okButton)
        
        let contentTextField = UITextView()
        contentTextField.scrollEnabled = false
        
        if content == nil {
            contentTextField.frame.size.height = 0
        } else {
            contentTextField.text = content
            if #available(iOS 8.2, *) {
                contentTextField.font = UIFont.systemFontOfSize(constants.contentFontSize, weight: UIFontWeightLight)
            } else {
                contentTextField.font = UIFont.systemFontOfSize(constants.contentFontSize)
            }
            contentTextField.textAlignment = NSTextAlignment.Natural
            contentTextField.backgroundColor = UIColor.clearColor()
            contentTextField.textColor = UIColor.blackColor()
            contentTextField.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight + constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)
            contentTextField.sizeToFit()
            contentTextField.editable = false
            
            if contentTextField.frame.size.height < constants.contentMaxHeightForCentralAlignment {
                contentTextField.textAlignment = .Center
            }
            else if contentTextField.frame.size.height > window.bounds.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements - 2 * constants.distanceToTop {
                contentTextField.frame.size.height = window.bounds.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements - 2 * constants.distanceToTop
                contentTextField.scrollEnabled = true
            }
        }
        mainView.addSubview(contentTextField)
        
        mainView.frame = CGRectMake(constants.distanceToLeft, (window.bounds.height - contentTextField.frame.size.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)/2, window.bounds.width - 2 * constants.distanceToLeft, contentTextField.frame.size.height + constants.titleHeight + constants.buttonHeight + 4 * constants.distanceBetweenElements)
        titleLabel.frame = CGRectMake(constants.distanceBetweenElements, constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.titleHeight)
        okButton.frame = CGRectMake(constants.distanceBetweenElements, contentTextField.frame.size.height + constants.titleHeight + 2 * constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.buttonHeight)
        contentTextField.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight +  constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, contentTextField.frame.size.height)
        blurView.frame = CGRectMake(0, 0, window.bounds.width - 2 * constants.distanceToLeft, contentTextField.frame.size.height + constants.titleHeight + constants.buttonHeight + 3 * constants.distanceBetweenElements)
        
        window.windowLevel = UIWindowLevelAlert
        window.center = referenceView!.center
        window.hidden = false
        window.backgroundColor = constants.backgroundColor
        window.addSubview(mainView)
        windows.append(window)
        
        okButton.addTarget(self, action: #selector(STPDPopNotification.tapDismiss(_:)), forControlEvents: .TouchUpInside)
    
        completionHandler(baseView: mainView)

    }
    
    private static func popStringNotificationButtonHandler(text: String, content: String?, completionHandler: (baseView: UIView)->(), leftButtonTitle: String, leftButtonHandler: (leftButton: UIButton)->(), rightButtonTitle: String, rightButtonHandler: (rightButton: UIButton)->()) {
        
        let window = UIWindow()
        let mainView = UIView()
        
        window.bounds = UIScreen.mainScreen().bounds
        mainView.layer.cornerRadius = constants.cornorRadius
        mainView.clipsToBounds = true
        mainView.backgroundColor = UIColor.clearColor()
        
        window.frame = CGRectMake(0, 0, window.bounds.width, window.bounds.height)
        mainView.frame = CGRectMake(constants.distanceToLeft, constants.distanceToTop, window.bounds.width - 2 * constants.distanceToLeft, window.bounds.height - 2 * constants.distanceToTop)
        
        let blurEff = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEff)
        blurView.frame = CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.width)
        blurView.layer.cornerRadius = constants.cornorRadius
        blurView.clipsToBounds = true
        mainView.addSubview(blurView)
        
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.numberOfLines = 0
        if #available(iOS 8.2, *) {
            titleLabel.font = UIFont.systemFontOfSize(constants.titleFontSize, weight: UIFontWeightRegular)
        } else {
            titleLabel.font = UIFont.systemFontOfSize(constants.titleFontSize)
        }
        
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.frame = CGRectMake(constants.distanceBetweenElements, constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.titleHeight)
        mainView.addSubview(titleLabel)
        
        let leftButton = UIButton()
        leftButton.setTitle(leftButtonTitle, forState: .Normal)
        if #available(iOS 8.2, *) {
            leftButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize, weight: UIFontWeightLight)
        } else {
            leftButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize)
        }
        
        leftButton.backgroundColor = constants.buttonColor
        
        leftButton.layer.cornerRadius = constants.buttonornorRadius
        leftButton.clipsToBounds = true
        
        leftButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        leftButton.frame = CGRectMake(constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.buttonHeight - constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements)/2, constants.buttonHeight)
        mainView.addSubview(leftButton)
        
        
        let rightButton = UIButton()
        rightButton.setTitle(rightButtonTitle, forState: .Normal)
        if #available(iOS 8.2, *) {
            rightButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize, weight: UIFontWeightLight)
        } else {
            rightButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize)
        }
        
        rightButton.backgroundColor = constants.buttonColor
        
        rightButton.layer.cornerRadius = constants.buttonornorRadius
        rightButton.clipsToBounds = true
        
        rightButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        rightButton.frame = CGRectMake(2 * constants.distanceBetweenElements + (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements)/2, window.bounds.height - 2 * constants.distanceToTop - constants.buttonHeight - constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements)/2, constants.buttonHeight)
        mainView.addSubview(rightButton)
        
        let contentTextField = UITextView()
        contentTextField.scrollEnabled = false
        
        if content == nil {
            contentTextField.frame.size.height = 0
        } else {
            contentTextField.text = content
            if #available(iOS 8.2, *) {
                contentTextField.font = UIFont.systemFontOfSize(constants.contentFontSize, weight: UIFontWeightLight)
            } else {
                contentTextField.font = UIFont.systemFontOfSize(constants.contentFontSize)
            }
            contentTextField.textAlignment = NSTextAlignment.Natural
            contentTextField.backgroundColor = UIColor.clearColor()
            contentTextField.textColor = UIColor.blackColor()
            contentTextField.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight + constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)
            contentTextField.sizeToFit()
            contentTextField.editable = false
            
            if contentTextField.frame.size.height < constants.contentMaxHeightForCentralAlignment {
                contentTextField.textAlignment = .Center
            }
            else if contentTextField.frame.size.height > window.bounds.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements - 2 * constants.distanceToTop {
                contentTextField.frame.size.height = window.bounds.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements - 2 * constants.distanceToTop
                contentTextField.scrollEnabled = true
            }
        }
        mainView.addSubview(contentTextField)
        
        mainView.frame = CGRectMake(constants.distanceToLeft, (window.bounds.height - contentTextField.frame.size.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)/2, window.bounds.width - 2 * constants.distanceToLeft, contentTextField.frame.size.height + constants.titleHeight + constants.buttonHeight + 4 * constants.distanceBetweenElements)
        titleLabel.frame = CGRectMake(constants.distanceBetweenElements, constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.titleHeight)
        
        leftButton.frame = CGRectMake(constants.distanceBetweenElements, contentTextField.frame.size.height + constants.titleHeight + 2 * constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements) / 2, constants.buttonHeight)
        
        
        
        rightButton.frame = CGRectMake(2 * constants.distanceBetweenElements + (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements)/2, contentTextField.frame.size.height + constants.titleHeight + 2 * constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements) / 2, constants.buttonHeight)
        
        contentTextField.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight +  constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, contentTextField.frame.size.height)
        blurView.frame = CGRectMake(0, 0, window.bounds.width - 2 * constants.distanceToLeft, contentTextField.frame.size.height + constants.titleHeight + constants.buttonHeight + 3 * constants.distanceBetweenElements)
        
        window.windowLevel = UIWindowLevelAlert
        window.center = referenceView!.center
        window.hidden = false
        window.backgroundColor = constants.backgroundColor
        window.addSubview(mainView)
        windows.append(window)
        
        
        leftButton.addTarget(self, action: #selector(STPDPopNotification.tapDismiss(_:)), forControlEvents: .TouchUpInside)
        rightButton.addTarget(self, action: #selector(STPDPopNotification.tapDismiss(_:)), forControlEvents: .TouchUpInside)
        
        leftButtonHandler(leftButton: leftButton)
        rightButtonHandler(rightButton: rightButton)
        
        completionHandler(baseView: mainView)
    }

    private static func imageNotification(text: String, imageFile: UIImage?, completionHandler: (baseView: UIView)->()) {
        
        let window = UIWindow()
        let mainView = UIView()
        
        window.bounds = UIScreen.mainScreen().bounds
        mainView.layer.cornerRadius = constants.cornorRadius
        mainView.clipsToBounds = true
        mainView.backgroundColor = UIColor.clearColor()
        
        window.frame = CGRectMake(0, 0, window.bounds.width, window.bounds.height)
        mainView.frame = CGRectMake(constants.distanceToLeft, constants.distanceToTop, window.bounds.width - 2 * constants.distanceToLeft, window.bounds.height - 2 * constants.distanceToTop)
        
        let blurEff = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEff)
        blurView.frame = CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.width)
        blurView.layer.cornerRadius = constants.cornorRadius
        blurView.clipsToBounds = true
        mainView.addSubview(blurView)
        
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.numberOfLines = 0
        if #available(iOS 8.2, *) {
            titleLabel.font = UIFont.systemFontOfSize(constants.titleFontSize, weight: UIFontWeightRegular)
        } else {
            titleLabel.font = UIFont.systemFontOfSize(constants.titleFontSize)
        }
        
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.frame = CGRectMake(constants.distanceBetweenElements, constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.titleHeight)
        mainView.addSubview(titleLabel)
        
        let okButton = UIButton()
        okButton.setTitle("Ok", forState: .Normal)
        if #available(iOS 8.2, *) {
            okButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize, weight: UIFontWeightLight)
        } else {
            okButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize)
        }
        
        okButton.backgroundColor = constants.buttonColor
        
        okButton.layer.cornerRadius = constants.buttonornorRadius
        okButton.clipsToBounds = true
        
        okButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        okButton.frame = CGRectMake(constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.buttonHeight - constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.buttonHeight)
        mainView.addSubview(okButton)
        
        let scrollView = UIScrollView()
        if imageFile == nil {
            scrollView.frame.size.height = 0
        } else {
            scrollView.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight + constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)
            
            let scrollImageView = UIImageView()
            scrollImageView.backgroundColor = UIColor.clearColor()
            scrollImageView.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight + constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)
            scrollImageView.contentMode = .ScaleAspectFit
            scrollImageView.image = imageFile
            scrollImageView.sizeToFit()
            
            let scrollImageSizeRate = scrollImageView.frame.size.height / scrollImageView.frame.size.width
            scrollView.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight + constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements) * scrollImageSizeRate)
            
            
            
            scrollView.userInteractionEnabled = true
            scrollView.contentSize = CGSizeMake(window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements) * scrollImageSizeRate)
            scrollView.scrollEnabled = true
            scrollView.showsVerticalScrollIndicator = true
            scrollView.backgroundColor = UIColor.whiteColor()
            
            scrollImageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
            scrollView.addSubview(scrollImageView)
            
            if scrollView.frame.size.height >  window.bounds.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements - 2 * constants.distanceToTop {
                scrollView.frame.size.height =  window.bounds.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements - 2 * constants.distanceToTop
            }
        }
        mainView.addSubview(scrollView)
        
        mainView.frame = CGRectMake(constants.distanceToLeft, (window.bounds.height - scrollView.frame.size.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)/2, window.bounds.width - 2 * constants.distanceToLeft, scrollView.frame.size.height + constants.titleHeight + constants.buttonHeight + 4 * constants.distanceBetweenElements)
        titleLabel.frame = CGRectMake(constants.distanceBetweenElements, constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.titleHeight)
        okButton.frame = CGRectMake(constants.distanceBetweenElements, scrollView.frame.size.height + constants.titleHeight + 2 * constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.buttonHeight)
        blurView.frame = CGRectMake(0, 0, window.bounds.width - 2 * constants.distanceToLeft, scrollView.frame.size.height + constants.titleHeight + constants.buttonHeight + 3 * constants.distanceBetweenElements)
        
        window.windowLevel = UIWindowLevelAlert
        window.center = referenceView!.center
        window.hidden = false
        window.backgroundColor = constants.backgroundColor
        window.addSubview(mainView)
        windows.append(window)
        
        okButton.addTarget(self, action: #selector(STPDPopNotification.tapDismiss(_:)), forControlEvents: .TouchUpInside)
        
        completionHandler(baseView: mainView)
    }
    
    private static func imageNotificationButtonHandler(text: String, imageFile: UIImage?, completionHandler: (baseView: UIView)->(), leftButtonTitle: String, leftButtonHandler: (leftButton: UIButton)->(), rightButtonTitle: String, rightButtonHandler: (rightButton: UIButton)->()) {
        
        let window = UIWindow()
        let mainView = UIView()
        
        window.bounds = UIScreen.mainScreen().bounds
        mainView.layer.cornerRadius = constants.cornorRadius
        mainView.clipsToBounds = true
        mainView.backgroundColor = UIColor.clearColor()
        
        window.frame = CGRectMake(0, 0, window.bounds.width, window.bounds.height)
        mainView.frame = CGRectMake(constants.distanceToLeft, constants.distanceToTop, window.bounds.width - 2 * constants.distanceToLeft, window.bounds.height - 2 * constants.distanceToTop)
        
        let blurEff = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEff)
        blurView.frame = CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.width)
        blurView.layer.cornerRadius = constants.cornorRadius
        blurView.clipsToBounds = true
        mainView.addSubview(blurView)
        
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.numberOfLines = 0
        if #available(iOS 8.2, *) {
            titleLabel.font = UIFont.systemFontOfSize(constants.titleFontSize, weight: UIFontWeightRegular)
        } else {
            titleLabel.font = UIFont.systemFontOfSize(constants.titleFontSize)
        }
        
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.frame = CGRectMake(constants.distanceBetweenElements, constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.titleHeight)
        mainView.addSubview(titleLabel)
        
        let leftButton = UIButton()
        leftButton.setTitle(leftButtonTitle, forState: .Normal)
        if #available(iOS 8.2, *) {
            leftButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize, weight: UIFontWeightLight)
        } else {
            leftButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize)
        }
        
        leftButton.backgroundColor = constants.buttonColor
        
        leftButton.layer.cornerRadius = constants.buttonornorRadius
        leftButton.clipsToBounds = true
        
        leftButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        leftButton.frame = CGRectMake(constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.buttonHeight - constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements)/2, constants.buttonHeight)
        mainView.addSubview(leftButton)
        
        
        let rightButton = UIButton()
        rightButton.setTitle(rightButtonTitle, forState: .Normal)
        if #available(iOS 8.2, *) {
            rightButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize, weight: UIFontWeightLight)
        } else {
            rightButton.titleLabel?.font = UIFont.systemFontOfSize(constants.buttonFontSize)
        }
        
        rightButton.backgroundColor = constants.buttonColor
        
        rightButton.layer.cornerRadius = constants.buttonornorRadius
        rightButton.clipsToBounds = true
        
        rightButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        rightButton.frame = CGRectMake(2 * constants.distanceBetweenElements + (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements)/2, window.bounds.height - 2 * constants.distanceToTop - constants.buttonHeight - constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements)/2, constants.buttonHeight)
        mainView.addSubview(rightButton)
        
        let scrollView = UIScrollView()
        if imageFile == nil {
            scrollView.frame.size.height = 0
        } else {
            scrollView.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight + constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)
            
            let scrollImageView = UIImageView()
            scrollImageView.backgroundColor = UIColor.clearColor()
            scrollImageView.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight + constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, window.bounds.height - 2 * constants.distanceToTop - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)
            scrollImageView.contentMode = .ScaleAspectFit
            scrollImageView.image = imageFile
            scrollImageView.sizeToFit()
            
            let scrollImageSizeRate = scrollImageView.frame.size.height / scrollImageView.frame.size.width
            scrollView.frame = CGRectMake(constants.distanceBetweenElements, constants.titleHeight + constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements) * scrollImageSizeRate)
            
            
            
            scrollView.userInteractionEnabled = true
            scrollView.contentSize = CGSizeMake(window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements) * scrollImageSizeRate)
            scrollView.scrollEnabled = true
            scrollView.showsVerticalScrollIndicator = true
            scrollView.backgroundColor = UIColor.whiteColor()
            
            scrollImageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
            scrollView.addSubview(scrollImageView)
            
            if scrollView.frame.size.height >  window.bounds.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements - 2 * constants.distanceToTop {
                scrollView.frame.size.height =  window.bounds.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements - 2 * constants.distanceToTop
            }
        }
        mainView.addSubview(scrollView)
        
        mainView.frame = CGRectMake(constants.distanceToLeft, (window.bounds.height - scrollView.frame.size.height - constants.titleHeight - constants.buttonHeight - 3 * constants.distanceBetweenElements)/2, window.bounds.width - 2 * constants.distanceToLeft, scrollView.frame.size.height + constants.titleHeight + constants.buttonHeight + 4 * constants.distanceBetweenElements)
        titleLabel.frame = CGRectMake(constants.distanceBetweenElements, constants.distanceBetweenElements, window.bounds.width - 2 * constants.distanceToLeft - 2 * constants.distanceBetweenElements, constants.titleHeight)
        
        leftButton.frame = CGRectMake(constants.distanceBetweenElements, scrollView.frame.size.height + constants.titleHeight + 2 * constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements) / 2, constants.buttonHeight)
        
        
        
        rightButton.frame = CGRectMake(2 * constants.distanceBetweenElements + (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements)/2, scrollView.frame.size.height + constants.titleHeight + 2 * constants.distanceBetweenElements, (window.bounds.width - 2 * constants.distanceToLeft - 3 * constants.distanceBetweenElements) / 2, constants.buttonHeight)
        
        blurView.frame = CGRectMake(0, 0, window.bounds.width - 2 * constants.distanceToLeft, scrollView.frame.size.height + constants.titleHeight + constants.buttonHeight + 3 * constants.distanceBetweenElements)
        
        window.windowLevel = UIWindowLevelAlert
        window.center = referenceView!.center
        window.hidden = false
        window.backgroundColor = constants.backgroundColor
        window.addSubview(mainView)
        windows.append(window)
        
        leftButton.addTarget(self, action: #selector(STPDPopNotification.tapDismiss(_:)), forControlEvents: .TouchUpInside)
        rightButton.addTarget(self, action: #selector(STPDPopNotification.tapDismiss(_:)), forControlEvents: .TouchUpInside)
        
        leftButtonHandler(leftButton: leftButton)
        rightButtonHandler(rightButton: rightButton)
        
        
        completionHandler(baseView: mainView)
    }
    
    @objc private static func tapDismiss (Sender: UIButton) {
        let index = windows.indexOf { $0 == Sender.superview?.window }
        if index != nil {
            UIView.animateWithDuration(0.18, animations: {
                Sender.superview!.center.y += UIScreen.mainScreen().bounds.height
                }, completion: { (Bool) in
                    windows[index!].hidden = true
                    windows[index!].removeFromSuperview()
                    windows.removeAtIndex(index!)
            })
        }
    }
    
    private static func clear() {
        for window in windows {
            window.hidden = true
            window.removeFromSuperview()
        }
        windows.removeAll()
    }

}


// MARK: - UIVIew Extensions Core Animation

extension UIView {
    
    func STPDAMShake(time: Float) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = time / 0.1
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(center.x, center.y - 8))
        animation.toValue = NSValue(CGPoint: CGPointMake(center.x, center.y + 8))
        layer.addAnimation(animation, forKey: "position")
    }
    
    func STPDAMBreath() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 2.5
        animation.repeatCount = FLT_MAX
        animation.autoreverses = true
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.addAnimation(animation, forKey: "opacity")
    }
    
    func STPDAMRotate(time: Float) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 0.05
        animation.repeatCount = time / 0.05
        animation.autoreverses = true
        animation.fromValue = -0.01
        animation.toValue = 0.01
        layer.addAnimation(animation, forKey: "transform.rotation.z")
    }
    
    func STPDAMRemoveAll() {
        layer.removeAllAnimations()
    }
    
}

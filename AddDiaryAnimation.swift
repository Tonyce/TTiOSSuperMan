//
//  AddDiaryTransition.swift
//  superman
//
//  Created by D_ttang on 15/7/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class AddDiaryAnimation: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ExtendTransition()
    }
    
    //    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    //        return ScaleTransition()
    //        return ExtendTransition()
    //    }
}

class OpenSettingAnimation: NSObject, UIViewControllerTransitioningDelegate {
    
    var fromFrame: CGRect = CGRectZero
    var fromFrameCenter: CGPoint = CGPointZero
    
    var settingTransition = SettingTransition()
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        settingTransition.fromFrame = fromFrame
        settingTransition.fromFrameCenter = fromFrameCenter
        return settingTransition
    }
    
    //    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    //        return ScaleTransition()
    //        return ExtendTransition()
    //    }
}


class ExtendTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var transitionContext: UIViewControllerContextTransitioning?
    
    
    var fromFrame: CGRect = CGRectZero
    var fromFrameCenter: CGPoint = CGPointZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let containerView = transitionContext.containerView()
        self.transitionContext = transitionContext
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let fromView = fromViewController.view //from view
        let toController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toView = toController.view
        
        containerView!.addSubview(fromView)
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(toView)
        
        let buttonFrame = fromViewController.addDiaryBtn.frame
        let buttonFrameCenter = fromViewController.addDiaryBtn.center

        let endFrame = CGRectMake(  buttonFrameCenter.x - CGRectGetHeight(toView.frame) , buttonFrameCenter.y-CGRectGetHeight(fromView.frame), CGRectGetHeight(toView.frame) * 2, CGRectGetHeight(toView.frame) * 2)
        
        let maskPath = UIBezierPath(ovalInRect: buttonFrame)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = toView.frame
        maskLayer.path = maskPath.CGPath
        maskLayer.fillColor = UIColor.redColor().CGColor
        toView.layer.mask = maskLayer
        
        let bigCirclePath = UIBezierPath(ovalInRect: endFrame)
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.delegate = self
        pathAnimation.fromValue = maskPath.CGPath
        pathAnimation.toValue = bigCirclePath
        pathAnimation.duration = 0.3

        maskLayer.path = bigCirclePath.CGPath
        maskLayer.addAnimation(pathAnimation, forKey: "pathAnimation")
        
        toView.backgroundColor = UIColor.whiteColor()
       
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let transitionContext = self.transitionContext {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}

class SettingTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var transitionContext: UIViewControllerContextTransitioning?
    
    
    var fromFrame: CGRect = CGRectZero
    var fromFrameCenter: CGPoint = CGPointZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let containerView = transitionContext.containerView()
        self.transitionContext = transitionContext
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let fromView = fromViewController.view //from view
        let toController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toView = toController.view
        
        containerView!.addSubview(fromView)
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(toView)
        
//        let buttonFrame = fromViewController.settingBtn.frame
//        let buttonFrameCenter = fromViewController.settingBtn.center

        let buttonFrame = fromViewController.selfImage.frame
        let buttonFrameCenter = fromViewController.selfImage.center
        
        let endFrame = CGRectMake(  buttonFrameCenter.x - CGRectGetHeight(toView.frame) , buttonFrameCenter.y-CGRectGetHeight(fromView.frame), CGRectGetHeight(toView.frame)*2.5, CGRectGetHeight(toView.frame)*2.5)
        
        let maskPath = UIBezierPath(ovalInRect: buttonFrame)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = toView.frame
        maskLayer.path = maskPath.CGPath
        maskLayer.fillColor = UIColor.redColor().CGColor
        toView.layer.mask = maskLayer
        
        let bigCirclePath = UIBezierPath(ovalInRect: endFrame)
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.delegate = self
        pathAnimation.fromValue = maskPath.CGPath
        pathAnimation.toValue = bigCirclePath
        pathAnimation.duration = 0.3
        
        maskLayer.path = bigCirclePath.CGPath
        maskLayer.addAnimation(pathAnimation, forKey: "pathAnimation")
        
        toView.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let transitionContext = self.transitionContext {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
//
//  AwesomeTransitioner.swift
//  CustomPresentation
//
//  Created by Nick Waynik on 10/26/14.
//  Copyright (c) 2014 Fresh App Factory. All rights reserved.
//

import UIKit

class AwesomeTransitioningDelegate: NSObject,
UIViewControllerTransitioningDelegate {
    
    var selectedObject: SelectionObject?
    
    init(selectedObject: SelectionObject) {
        super.init()
        self.selectedObject = selectedObject
    }
    
    func presentationControllerForPresentedViewController(
        presented: UIViewController,
        presentingViewController presenting: UIViewController,
        sourceViewController source: UIViewController)
        -> UIPresentationController? {
            
            let presentationController = AwesomePresentationController(presentedViewController: presented, presentingViewController: presenting)
            
            presentationController.configureWithSelectionObject(selectedObject!)
            return presentationController
    }
    
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            let animationController = AwesomeAnimatedTransitioning( selectedObject: selectedObject!, isPresentation: true)
            return animationController
    }
    
    func animationControllerForDismissedController(
        dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            
            let animationController = AwesomeAnimatedTransitioning(selectedObject: selectedObject!,isPresentation: false)
            
            return animationController
    }
    
}

class AwesomeAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentation: Bool = false
    var selectedObject: SelectionObject?
    
    init(selectedObject: SelectionObject, isPresentation: Bool) {
        self.selectedObject = selectedObject
        self.isPresentation = isPresentation
    }
    
    func transitionDuration(_transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        

        let fromViewController = transitionContext.viewControllerForKey( UITransitionContextFromViewControllerKey)
        let fromView = fromViewController!.view
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toViewController!.view
        
        let containerView: UIView = transitionContext.containerView()!
        
        if isPresentation {
            containerView.addSubview(toView)
        }
        
        let animatingViewController = isPresentation ? toViewController : fromViewController
        let animatingView = animatingViewController!.view
        
        animatingView.frame = transitionContext.finalFrameForViewController(animatingViewController!)
        
        let appearedFrame = transitionContext.finalFrameForViewController( animatingViewController!)
        
        var dismissedFrame = appearedFrame
        dismissedFrame.origin.y += dismissedFrame.size.height
        
        let initialFrame = isPresentation ? dismissedFrame : appearedFrame
        let finalFrame = isPresentation ? appearedFrame : dismissedFrame
        
        animatingView.frame = initialFrame
        
        // Add the following new code...
        let uiNavigationController = (isPresentation ? fromViewController : toViewController) as! UINavigationController
        
        let countriesViewController = uiNavigationController.viewControllers[1] as! SuperGaysViewController
       
//        let countriesViewController: SuperGaysViewController = (isPresentation ? fromViewController : toViewController) as! SuperGaysViewController
//        let countriesViewController = UIStoryboard.instantiateViewControllerWithIdentifier("SuperGaysView") as SuperGaysViewController

        
        if !isPresentation {
            countriesViewController.hideImage(true, indexPath: selectedObject!.selectedCellIndexPath)
        }
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            delay: 0.0,
            options: [UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.BeginFromCurrentState],
            animations: {
                animatingView.frame = finalFrame
                
                // Add the following new code...
                countriesViewController.changeCellSpacingForPresentation(self.isPresentation)
                
            }, completion: { (value: Bool) in
                if !self.isPresentation {
                    
                    // Add the following new code...
                    countriesViewController.hideImage(false, indexPath:
                        self.selectedObject!.selectedCellIndexPath)
                    
                    
                    UIView.animateWithDuration(0.3, animations: {
                        fromView.alpha = 0.0;
                        }, completion: {
                            (value: Bool) in
                            fromView.removeFromSuperview()
                            transitionContext.completeTransition(true)
                    })
                } else { // Existing
                    transitionContext.completeTransition(true)
                }
        })
    }
    
}


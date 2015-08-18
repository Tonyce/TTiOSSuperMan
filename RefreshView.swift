//
//  RefreshView.swift
//  superman
//
//  Created by D_ttang on 15/8/13.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import QuartzCore

// MARK: Refresh View Delegate Protocol
protocol RefreshViewDelegate {
    func refreshViewDidRefresh(refreshView: RefreshView)
}

class RefreshView: UIView {
    
    var delegate: RefreshViewDelegate?
    var scrollView: UIScrollView?
    var refreshing: Bool = false
    var progress: CGFloat = 0.0
    
    var isRefreshing = false
    
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    let airplaneLayer: CALayer = CALayer()
    /*
    func giveScrollView(scrollView: UIScrollView){
        self.scrollView = scrollView
        
        ovalShapeLayer.strokeColor = UIColor.redColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 4.0
//        ovalShapeLayer.lineDashPattern = [2, 3]
        let refreshRadius = frame.size.height/2 * 0.8
        ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(
            x: frame.size.width/2 - refreshRadius,
            y: frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius)
            ).CGPath
        
        layer.addSublayer(ovalShapeLayer)
    }
    */
    init(frame: CGRect, scrollView: UIScrollView) {
        super.init(frame: frame)
        
        self.scrollView = scrollView
        
        ovalShapeLayer.strokeColor = UIColor.redColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 2.0
//        ovalShapeLayer.lineDashPattern = [2, 3]
        let refreshRadius = frame.size.height/2 * 0.5
        ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(
            x: frame.size.width/2 - refreshRadius,
            y: frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius)
            ).CGPath
        
        layer.addSublayer(ovalShapeLayer)

    }
    /**/

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: animate the Refresh View
    
    func beginRefreshing() {
        isRefreshing = true
        self.layer.zPosition = 100
        UIView.animateWithDuration(0.3, animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top += self.frame.size.height
            self.scrollView!.contentInset = newInsets
        })
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.5
        strokeAnimationGroup.repeatDuration = 5.0
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        ovalShapeLayer.addAnimation(strokeAnimationGroup, forKey: nil)
        
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = ovalShapeLayer.path
        flightAnimation.calculationMode = kCAAnimationPaced
        
        let airplaneOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        airplaneOrientationAnimation.fromValue = 0
        airplaneOrientationAnimation.toValue = 2 * M_PI
        
        let flightAnimationGroup = CAAnimationGroup()
        flightAnimationGroup.duration = 1.5
        flightAnimationGroup.repeatDuration = 5.0
        flightAnimationGroup.animations = [flightAnimation, airplaneOrientationAnimation]
        airplaneLayer.addAnimation(flightAnimationGroup, forKey: nil)
        
    }
    
    func endRefreshing() {
        isRefreshing = false
        self.layer.zPosition = -100
        UIView.animateWithDuration(0.3, delay:0.0, options: .CurveEaseOut ,animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top -= self.frame.size.height
            self.scrollView!.contentInset = newInsets
            }, completion: {_ in
                //finished
        })
    }
    
    func redrawFromProgress(progress: CGFloat) {
        ovalShapeLayer.strokeEnd = progress
        airplaneLayer.opacity = Float(progress)
    }

}

extension RefreshView: UIScrollViewDelegate {
    // MARK: Scroll View Delegate methods
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = CGFloat( max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0))
        self.progress = min(max(offsetY / frame.size.height, 0.0), 1.0)
        
        if !isRefreshing {
            redrawFromProgress(self.progress)
        }
    }
    
    //  func scrollViewWillEndDragging(scrollView: UIScrollView!, withVelocity velocity: CGPoint, targetContentOffset: UnsafePointer<CGPoint>) {
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && self.progress >= 1.0 {
            delegate?.refreshViewDidRefresh(self)
            beginRefreshing()
        }
    }
}
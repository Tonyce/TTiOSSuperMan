//
//  FriendsViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    var swipeableView:MABCardsContainer!
    var colorIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swipeableView = MABCardsContainer(frame: CGRectMake(20, 30, 280, 400))
//                self.swipeableView = MABCardsContainer(frame: CGRectZero)
        
        self.swipeableView.backgroundColor = UIColor.redColor()
//        self.swipeableView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        swipeableView.translatesAutoresizingMaskIntoConstraints = false
//        let widthConstraint = NSLayoutConstraint(item: swipeableView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
//        view.addConstraint(widthConstraint)
//        let heightConstraint = NSLayoutConstraint(item: swipeableView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: -44)
//        
//        view.addConstraint(heightConstraint)
        
        self.swipeableView.setNeedsLayout()
        self.swipeableView.layoutIfNeeded()
        self.swipeableView.dataSource = self
        self.swipeableView.delegate = self
        
        //        self.swipeableView.backgroundColor = UIColor.redColor()
        
        let btn = UIButton(frame: CGRectMake(10, 430, 300, 50))
        btn.setTitle("Reload Cards", forState: UIControlState.Normal)
        //btn.backgroundColor = UIColor.blackColor()
        btn.addTarget(self, action: "reload", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(swipeableView)
        
//        self.view.addConstraints(
//            NSLayoutConstraint.constraintsWithVisualFormat(
//                "H:|-[myLabel]-|", options: nil, metrics: nil, views: viewsDict))
        
        self.view.addSubview(btn)
        
        self.reload()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FriendsViewController: MABCardsContainerDelegate, MABCardsContainerDataSource {
    
    
    
    
    
    func reload() {
        self.colorIndex = 0
        self.swipeableView.discardAllSwipeableViews()
        self.swipeableView.loadNextSwipeableViewsIfNeeded(true)
    }
    
    
    func generateColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    
    // MABCardsContainerDelegate
    func containerViewDidSwipeLeft(containerView:MABCardsContainer, _: UIView) {
        print("SwipeLeft")
    }
    func containerViewDidSwipeRight(containerView:MABCardsContainer, _: UIView) {
        print("SwipeRight")
    }
    func containerViewDidStartSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint) {
        print("StartSwipingCard")
    }
    func containerSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint, translation:CGPoint) {
        //        print("SwipingCard")
    }
    func containerViewDidEndSwipingCard(containerView:MABCardsContainer, card:UIView, location:CGPoint) {
        print("endSwipingCard")
    }
    
    // MABCardsContainerDataSource
    func nextCardViewForContainerView(containerView:MABCardsContainer) -> UIView! {
        if (self.colorIndex < 10) {
            let card = MABCardView(frame: swipeableView.bounds)
            let tap = UITapGestureRecognizer(target: self, action: "clickCard:")
            card.addGestureRecognizer(tap)
            card.backgroundColor = self.generateColor()
            self.colorIndex++;
            return card;
        }
        return nil;
    }
    
    func clickCard(sender: UIGestureRecognizer){
        print("click card")
    }
    
}

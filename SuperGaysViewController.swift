//
//  SuperGaysViewController.swift
//  superman
//
//  Created by D_ttang on 15/8/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SuperGaysViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewLeadingConstraint: NSLayoutConstraint!
    
    var countries = Country.countries()
    var awesomeTransitionDelegate:AwesomeTransitioningDelegate?
        let simpleTransitionDelegate = SimpleTransitioningDelegate()
    var selectionObject: SelectionObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let flowLayout = CollectionViewLayout(traitCollection: traitCollection)
        
        flowLayout.invalidateLayout()
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        
        collectionView.reloadData()
    }
    
    override func traitCollectionDidChange(previousTraitCollection: (UITraitCollection!)) {
        if collectionView.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
            
            // Increase leading and trailing constraints to center cells
            var padding: CGFloat = -16.0
            let viewWidth = view.frame.size.width
            
            if viewWidth > 320.0 {
                padding = ((viewWidth - 320.0)) / 2.0 - 30.0
            }
            
            collectionViewLeadingConstraint.constant = padding
            collectionViewTrailingConstraint.constant = padding
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func numberOfSectionsInCollectionView(collectionView:UICollectionView!) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
            
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
            
        let country = countries[indexPath.row] as! Country
        let image: UIImage = UIImage(named: country.imageName)!
        cell.imageView.image = image
        cell.imageView.layer.cornerRadius = 4.0
        
        // Add the following new code...
        if selectionObject != nil && selectionObject?.country.countryName == country.countryName {
            cell.imageView.hidden = selectionObject!.country.isHidden
        } else {
            cell.imageView.hidden = false
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        showAwesomeOverlayForIndexPath(indexPath)
//        showSimpleOverlayForIndexPath(indexPath)
    }
    
    func showSimpleOverlayForIndexPath(indexPath: NSIndexPath) {
        let country = countries[indexPath.row] as! Country
        
        transitioningDelegate = simpleTransitionDelegate
        
        let overlay = OverlayViewController(country: country)
        overlay.transitioningDelegate = simpleTransitionDelegate
        
        presentViewController(overlay, animated: true, completion: nil)
    }
    
    func showAwesomeOverlayForIndexPath(indexPath: NSIndexPath) {
        let country = countries[indexPath.row] as! Country
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        // 1
        var rect = selectedCell.frame
        let origin = view.convertPoint(rect.origin, fromView: selectedCell.superview)
        
        rect.origin = origin
        
        // 2
        // Add the following new code...
        selectionObject = SelectionObject(country: country, selectedCellIndexPath: indexPath, originalCellPosition: rect)
        
        // 3
        awesomeTransitionDelegate = AwesomeTransitioningDelegate(selectedObject: selectionObject!)
        transitioningDelegate = awesomeTransitionDelegate
        
        // 4
        let overlay = OverlayViewController(country: country)
        
        //        print("\(overlay.view.frame)")
        overlay.transitioningDelegate = awesomeTransitionDelegate
        presentViewController(overlay, animated: true,completion: nil)
        
        UIView.animateWithDuration(0.1,
            animations:{
                selectedCell.imageView.alpha = 0.0
            }, completion: nil)
        //
    }
    
    
    func hideImage(hidden: Bool, indexPath: NSIndexPath) {
        if selectionObject != nil {
            selectionObject!.country.isHidden = hidden
        }
        
        if indexPath.row < self.countries.count {
            collectionView.reloadItemsAtIndexPaths([indexPath])
        }
    }
    
    func indexPathsForAllItems() -> [NSIndexPath] {
        let count = countries.count
        var indexPaths: [NSIndexPath] = []
        for var index = 0; index < count; ++index {
            indexPaths.append(NSIndexPath(forItem: index,
                inSection: 0))
        }
        return indexPaths
    }
    
    func changeCellSpacingForPresentation(presentation: Bool) {
        if presentation {
            let indexPaths = indexPathsForAllItems()
            countries = NSArray()
            collectionView.deleteItemsAtIndexPaths(indexPaths)
        } else {
            countries = Country.countries()
            let indexPaths = indexPathsForAllItems()
            collectionView.insertItemsAtIndexPaths(indexPaths)
        }
    }
    
    func frameForCellAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        return cell.frame
    }
}

/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class CountriesViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var collectionViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var collectionViewTrailingConstraint: NSLayoutConstraint!
    
    var countries = Country.countries()

    var awesomeTransitionDelegate:AwesomeTransitioningDelegate?
    var selectionObject: SelectionObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "BackgroundImage")
        
        let flowLayout = CollectionViewLayout(traitCollection: traitCollection)
        
        flowLayout.invalidateLayout()
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        
        collectionView.reloadData()
    }
    
    
    override func traitCollectionDidChange(previousTraitCollection:
        (UITraitCollection!)) {
            
            if collectionView.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
                
                // Increase leading and trailing constraints to center cells
                var padding: CGFloat = 0.0
                let viewWidth = view.frame.size.width
                
                if viewWidth > 320.0 {
                    padding = (viewWidth - 320.0) / 2.0
                }
                
                collectionViewLeadingConstraint.constant = padding
                collectionViewTrailingConstraint.constant = padding
            }
    }
    
    
    // pragma mark - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView:
        UICollectionView!) -> Int {
            return 1
    }
    
    func collectionView(collectionView: UICollectionView!,
        numberOfItemsInSection section: Int) -> Int {
            
            return countries.count
    }
    
    func collectionView(collectionView: UICollectionView!,
        cellForItemAtIndexPath indexPath: NSIndexPath!) ->
        UICollectionViewCell! {
            
            let cell: CollectionViewCell =
            collectionView.dequeueReusableCellWithReuseIdentifier(
                "CollectionViewCell", forIndexPath: indexPath)
                as! CollectionViewCell;
            
            let country = countries[indexPath.row] as! Country
            let image: UIImage = UIImage(named: country.imageName)!;
            cell.imageView.image = image;
            cell.imageView.layer.cornerRadius = 4.0
            
            // Add the following new code...
            if selectionObject != nil &&
                selectionObject?.country.countryName == country.countryName {
                    cell.imageView.hidden = selectionObject!.country.isHidden
            } else {
                cell.imageView.hidden = false
            }
            
            
            return cell;
    }
    
    
    // pragma mark - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        showAwesomeOverlayForIndexPath(indexPath)
//        showSimpleOverlayForIndexPath(indexPath)
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
        selectionObject = SelectionObject(country: country,
            selectedCellIndexPath: indexPath,
            originalCellPosition: rect)
        
        // 3
        awesomeTransitionDelegate = AwesomeTransitioningDelegate(selectedObject: selectionObject!)
        transitioningDelegate = awesomeTransitionDelegate
        
        // 4
        let overlay = OverlayViewController(country: country)
        
//        print("\(overlay.view.frame)")
        overlay.transitioningDelegate = awesomeTransitionDelegate
        presentViewController(overlay, animated: true,completion: nil)
        
        UIView.animateWithDuration(0.1, animations:{
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
    
    func frameForCellAtIndexPath(indexPath: NSIndexPath) ->
        CGRect {
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
                as! CollectionViewCell
            return cell.frame
    }
    
    
}


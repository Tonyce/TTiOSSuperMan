//
//  ImageExtension.swift
//  superman
//
//  Created by D_ttang on 15/7/16.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    func getSubImage(rect: CGRect) -> UIImage{
        
        let subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect)
        let smallBounds:CGRect = CGRectMake(CGFloat(0.0), CGFloat(0.0), CGFloat(CGImageGetWidth(subImageRef)), CGFloat(CGImageGetHeight(subImageRef)))
        
        UIGraphicsBeginImageContext(smallBounds.size)
        let context: CGContextRef  = UIGraphicsGetCurrentContext()!
        CGContextDrawImage(context, smallBounds, subImageRef)
        let smallImage:UIImage = UIImage(CGImage: subImageRef!)
        UIGraphicsEndImageContext()
        
        return smallImage
    }
    
    func scaleToSize(viewWidth: CGFloat) -> UIImage{
        let sizeWidth = viewWidth
        let sizeHeight = viewWidth / self.size.width * self.size.height
        let size = CGSize(width: sizeWidth, height: sizeHeight)
        print("size: \(size)")
        UIGraphicsBeginImageContext(size)
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
}

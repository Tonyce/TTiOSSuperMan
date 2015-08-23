//
//  MyCustomView.swift
//  superman
//
//  Created by D_ttang on 15/7/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class MyCustomView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
//    override func drawRect(rect: CGRect) {
//        // Drawing code
//        
//        let ctx:CGContextRef = UIGraphicsGetCurrentContext()
//        
//        CGContextBeginPath(ctx)
//        
//        CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMidY(rect) + 50)
////        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 60)
//        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect))
//        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect))
//        
//        CGContextClosePath(ctx);
//        
//        CGContextSetRGBFillColor(ctx, 255/255.0, 255/255.0, 255/255.0, 1);
//        CGContextFillPath(ctx);
//    }
    
//    convenience init(frame: CGRect, color: UIColor) {
//        self.init(frame: frame)
//        
//        let ctx:CGContextRef = UIGraphicsGetCurrentContext()
//        
//        CGContextBeginPath(ctx)
//        
//        CGContextMoveToPoint   (ctx, CGRectGetMinX(frame), CGRectGetMinY(frame))
//        //        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 60)
//        CGContextAddLineToPoint(ctx, CGRectGetMaxX(frame), CGRectGetMinY(frame))
//        CGContextAddLineToPoint(ctx, CGRectGetMaxX(frame), CGRectGetMaxY(frame))
//        CGContextAddLineToPoint(ctx, CGRectGetMinX(frame), CGRectGetMaxY(frame) - 80)
//        
//        CGContextClosePath(ctx);
//        
//        //        CGContextSetRGBFillColor(ctx, 200/255.0, 200/255.0, 200/255.0, 1);
//        CGContextSetFillColorWithColor(ctx, color.CGColor)
//        //        CGContextSetShadowWithColor(ctx, CGSize(width: 0.5, height: 1), 0.1, UIColor.blackColor().CGColor)
//        CGContextSetShadow(ctx, CGSize(width: 0.5, height: 1), 1)
//        CGContextFillPath(ctx)
//    }
//    
//    override init(frame: CGRect){
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
//        super.init(coder: aDecoder)
//    }

    
    var bkColor: UIColor? {
        didSet {
            self.setCtxColor()
        }
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
//                let ctx:CGContextRef = UIGraphicsGetCurrentContext()
//        
//        CGContextBeginPath(ctx)
//        
//        CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect))
//        //        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 60)
//        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect))
//        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect))
//        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect) - 80)
//        
//        CGContextClosePath(ctx);
//        
////        CGContextSetRGBFillColor(ctx, 200/255.0, 200/255.0, 200/255.0, 1);
//        CGContextSetFillColorWithColor(ctx, bkColor!.CGColor)
//        //        CGContextSetShadowWithColor(ctx, CGSize(width: 0.5, height: 1), 0.1, UIColor.blackColor().CGColor)
//        CGContextSetShadow(ctx, CGSize(width: 0.5, height: 1), 1)
//        CGContextFillPath(ctx)
    }
    
    func setCtxColor(){
                let ctx:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(ctx, bkColor!.CGColor)
//        let ctx:CGContextRef = NSGraphicsContext.currentContext?.CGContext
//        CGContextSetFillColorWithColor(ctx, bkColor!.CGColor)
    }
}

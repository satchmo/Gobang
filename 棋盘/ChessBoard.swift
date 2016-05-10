//
//  棋盘.swift
//  棋盘
//
//  Created by ufogxl on 16/5/4.
//  Copyright © 2016年 ufogxl. All rights reserved.
//

import UIKit
import CoreGraphics

class ChessBoard: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2)
        let lineLengh = self.bounds.width
        lineSpace = lineLengh/16
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        for(var i = 1;i <= 15;i = i + 1){
            CGContextMoveToPoint(context, 0, CGFloat(i) * lineSpace)
            CGContextAddLineToPoint(context, lineLengh, CGFloat(i) * lineSpace)
            CGContextMoveToPoint(context, CGFloat(i) * lineSpace, 0)
            CGContextAddLineToPoint(context, CGFloat(i) * lineSpace, lineLengh)
        }
        CGContextStrokePath(context)
        CGContextSetLineWidth(context, 10)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextAddRect(context, rect)
        CGContextStrokePath(context)
    }

    var lineSpace:CGFloat!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clearColor()
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

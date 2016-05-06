//
//  Chess.swift
//  棋盘
//
//  Created by ufogxl on 16/5/4.
//  Copyright © 2016年 ufogxl. All rights reserved.
//

import UIKit

class Chess: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        if isSetted == true{
            CGContextSetLineWidth(context, 0.5)
        }else{
            CGContextSetLineWidth(context, 5)
        }
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetFillColorWithColor(context, currentColor.CGColor)
        CGContextAddEllipseInRect(context, CGRectMake(rect.origin.x + 3, rect.origin.y + 3, rect.size.width - 6, rect.size.height - 6))
        CGContextDrawPath(context, .FillStroke)
        
    }
    
    var isSetted:Bool!
    var currentColor = UIColor.whiteColor()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsDisplay()
    }

    init(frame:CGRect,color:UIColor,isSetted:Bool){
        super.init(frame: frame)
        self.isSetted = isSetted
        currentColor = color
        self.backgroundColor = .clearColor()
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

enum ChessColor{
    case blank
    case black
    case white
}

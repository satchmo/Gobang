//
//  ViewController.swift
//  棋盘
//
//  Created by ufogxl on 16/5/4.
//  Copyright © 2016年 ufogxl. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        drawView()
    }

    var chesses:[Chess]!
    var chessPad:[[ChessColor]]!
    var chessBoard:ChessBoard!
    var chessOrigin:CGPoint!
    var lineSpace:CGFloat!
    var currentLoc:(row:Int,column:Int) = (0,0)
    var chessColor = UIColor.whiteColor()
    var startButton:UIButton!
    var reStartButton:UIButton!
    var isInGame:Bool = false
    var currentChessLabel:UILabel!
    var currentChessView:UIView!
    var currentStep:UILabel!
    
    func drawView(){
        let bounds = self.view.bounds
        //棋盘
        chessBoard = ChessBoard(frame: CGRectMake(40,100,bounds.width - 80,bounds.width - 80))
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.addTarget(self, action: "chessPutted:")
        chessBoard.addGestureRecognizer(tapGestureRecognizer)
        view.addSubview(chessBoard)
        chessBoard.translatesAutoresizingMaskIntoConstraints = false
        lineSpace = chessBoard.frame.width/16
        let boardOrigin = CGPointMake(40, 100)
        chessOrigin = CGPointMake(boardOrigin.x - lineSpace/2, boardOrigin.y - lineSpace/2)
        startButton = UIButton(frame: CGRectMake(120,chessBoard.frame.origin.y + chessBoard.frame.width + 40,bounds.width - 240,80))
        startButton.backgroundColor = .blueColor()
        startButton.setTitle("开始游戏", forState: .Normal)
        startButton.titleLabel?.font = UIFont.systemFontOfSize(40)
        startButton.layer.cornerRadius = 10
        
        startButton.addTarget(self, action: "initGame", forControlEvents: .TouchUpInside)
        view.addSubview(startButton)
    }
    
    func initGame(){
        print("----")
//        let bounds = self.view.bounds
        chesses = []
        var chessColumn:[ChessColor] = []
        for (var i = 0;i <= 16;i = i + 1){
            chessColumn.append(.blank)
        }
        chessPad = []
        for (var i = 0;i <= 16;i = i + 1){
            chessPad.append(chessColumn)
        }
        isInGame = true
        
    }
    
    func chessPutted(sender:UITapGestureRecognizer){
        print("1213")
        let location = sender.locationInView(self.view)
        let pointX = location.x
        let pointY = location.y
        let rowSpace = pointX - chessOrigin.x
        let columnSpace = pointY - chessOrigin.y
        
        print(isInGame)
        if !isInGame {
            return
        }
        

        // 非操作区无响应
        if rowSpace < -0.5 || rowSpace > 17 * lineSpace
            || columnSpace < -0.5 || columnSpace > 17 * lineSpace{
                return
        }
        let row = Int(rowSpace/lineSpace)
        let column = Int(columnSpace/lineSpace)
        //下过的位置无响应
        if chessPad[row][column] != .blank{
            return
        }

        //新的棋子到来，上步棋去掉标记
        if chesses.count > 0{
            let frame = (chesses.last! as Chess).frame
            chesses.last?.removeFromSuperview()
            chesses.removeLast()
            let chess = Chess(frame: frame,color:chessColor,isSetted:true)
            view.addSubview(chess)
            chesses.append(chess)
        }
        
        if chessColor == UIColor.blackColor(){
            chessColor = UIColor.whiteColor()
        }else{
            chessColor = UIColor.blackColor()
        }
        let chessCenter = CGPointMake(chessOrigin.x + (CGFloat(row) + 0.5) * lineSpace, chessOrigin.y + (CGFloat(column) + 0.5) * lineSpace)
        let chess = Chess(frame: CGRectMake(chessCenter.x - lineSpace/2,chessCenter.y - lineSpace/2,lineSpace,lineSpace),color:chessColor,isSetted:false)
        view.addSubview(chess)
        chesses.append(chess)
        //上色
        chessPad[row][column] = chessColor == UIColor.blackColor() ? .black : .white
        currentLoc.row = row
        currentLoc.column = column
        
        //判断游戏是否结束
        guardGameOver()
        
    }
    
   func guardGameOver(){
        let color:ChessColor = chessColor == UIColor.blackColor() ? .black: .white
        var loc = currentLoc
        var count1 = 1
        var count2 = 0
        //左上
        while (loc.row > 0)&&(loc.column > 0){
            if chessPad[loc.row - 1][loc.column - 1] == color{
                count1 = count1 + 1
                if count1 >= 5{
                    stopGame()
                }
            }else{
                break
            }
            loc.row = loc.row - 1
            loc.column = loc.column - 1
        }

        //右下
        loc.row = currentLoc.row
        loc.column = currentLoc.column
        while (loc.row < 16)&&(loc.column < 16){
            if chessPad[loc.row + 1][loc.column + 1] == color{
                count2 = count2 + 1
                if count1 + count2 >= 5{
                    stopGame()
                }
            }else{
                break
            }
            loc.row = loc.row + 1
            loc.column = loc.column + 1
        }
        //左下
        count1 = 1
        loc.row = currentLoc.row
        loc.column = currentLoc.column
        while (loc.row < 16)&&(loc.column > 0){
            if chessPad[loc.row + 1][loc.column - 1] == color{
                count1 = count1 + 1
                if count1 >= 5{
                    stopGame()
                }
            }else{
                break
            }
            loc.row = loc.row + 1
            loc.column = loc.column - 1
        }
        //右上
        count2 = 0
        loc.row = currentLoc.row
        loc.column = currentLoc.column
        while (loc.row > 0)&&(loc.column < 16){
            if chessPad[loc.row - 1][loc.column + 1] == color{
                count2 = count2 + 1
                if count1 + count2 >= 5{
                    stopGame()
                }
            }else{
                break
            }
            loc.row = loc.row - 1
            loc.column = loc.column + 1
            
        }
        //上
        count1 = 1
        loc.row = currentLoc.row
        loc.column = currentLoc.column
        while (loc.row > 0){
            if chessPad[loc.row - 1][loc.column] == color{
                count1 = count1 + 1
                if count1 >= 5{
                    stopGame()
                }
            }else{
                break
            }
            loc.row = loc.row - 1
        }
        //下
        count2 = 0
        loc.row = currentLoc.row
        loc.column = currentLoc.column
        while (loc.row < 16){
            if chessPad[loc.row + 1][loc.column] == color{
                count2 = count2 + 1
                if count1 + count2 >= 5{
                    stopGame()
                }
            }else{
                break
            }
            loc.row = loc.row + 1
        }
        //左
        count1 = 1
        loc.row = currentLoc.row
        loc.column = currentLoc.column
        while (loc.column > 0){
            if chessPad[loc.row][loc.column - 1] == color{
                count1 = count1 + 1
                if count1 >= 5{
                    stopGame()
                }
            }else{
                break
            }
            loc.column = loc.column - 1
        }
        //右
        count2 = 0
        loc.row = currentLoc.row
        loc.column = currentLoc.column
        while (loc.column < 16){
        if chessPad[loc.row][loc.column + 1] == color{
            count2 = count2 + 1
            if count1 + count2 >= 5{
                stopGame()
            }
        }else{
            break
        }
        loc.column = loc.column + 1
    }
        return
    }
    
    func stopGame(){
        isInGame = false
    }
    
    func resetGame(){
        
    }


}


//
//  ViewController.swift
//  test
//
//  Created by ufogxl on 16/5/5.
//  Copyright © 2016年 ufogxl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mview = UIView(frame: CGRectMake(0,0,200,200))
        mview.backgroundColor = UIColor.blackColor()
        let rec = UITapGestureRecognizer()
        rec.numberOfTapsRequired = 1
        rec.addTarget(self, action: "tap")
        mview.addGestureRecognizer(rec)
        view.addSubview(mview)
        
        let bt = UIButton(frame: CGRectMake(100,210,100,50))
        bt.backgroundColor = .yellowColor()
        bt.addTarget(self, action: "bt", forControlEvents: .TouchUpInside)
        view.addSubview(bt)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tap(){
        print("------")
    }
    
    func bt(){
        print("******")
    }

}


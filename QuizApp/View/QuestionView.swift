//
//  QuestionView.swift
//  QuizApp
//
//  Created by five on 29/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import PureLayout

class QuestionView: UIView {
    
    var shouldSetupConstraints = true
    
    var qlabel: UILabel = UILabel()
    var button_a = makeButton(background: .blue)
    var button_b = makeButton(background: .blue)
    var button_c = makeButton(background: .blue)
    var button_d = makeButton(background: .blue)
    var button_exit = makeButton(background: .blue)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addCustomView() {
        qlabel.backgroundColor=UIColor.white
        qlabel.frame = CGRect(x: 0,y: 0,width: self.frame.width, height: self.frame.height / 6)
        qlabel.textAlignment = NSTextAlignment.center
        self.addSubview(qlabel)
        
        button_a.frame = CGRect(x: 0,y: self.frame.height / 6,width: self.frame.width, height: self.frame.height / 6)
        self.addSubview(button_a)
        
        button_b.frame = CGRect(x: 0,y: self.frame.height * 2/6,width: self.frame.width, height: self.frame.height / 6)
        self.addSubview(button_b)
        
        button_c.frame = CGRect(x: 0,y: self.frame.height * 3/6,width: self.frame.width, height: self.frame.height / 6)
        self.addSubview(button_c)
        
        button_d.frame = CGRect(x: 0,y: self.frame.height * 4/6,width: self.frame.width, height: self.frame.height / 6)
        self.addSubview(button_d)
        
        button_exit.frame = CGRect(x: 0,y: self.frame.height * 5/6,width: self.frame.width, height: self.frame.height / 6)
        self.addSubview(button_exit)
        

    }
    

//    override func updateViewConstraints() {
//      if(shouldSetupConstraints) {
//        qlabel.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 6))
//        qlabel.autoPinEdge(toSuperviewEdge: .top, withInset: self.frame.height / 20)
//        button_a.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 6))
//        button_a.autoPinEdge(.top, to: .bottom, of: qlabel, withOffset: self.frame.height / 30)
//        button_b.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 6))
//        button_b.autoPinEdge(.top, to: .bottom, of: button_a, withOffset: self.frame.height / 30)
//        button_c.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 6))
//        button_c.autoPinEdge(.top, to: .bottom, of: button_b, withOffset: self.frame.height / 30)
//        button_d.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 6))
//        button_d.autoPinEdge(.top, to: .bottom, of: button_c, withOffset: self.frame.height / 30)
//        button_exit.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 6))
//        button_exit.autoPinEdge(.top, to: .bottom, of: button_d, withOffset: self.frame.height / 30)
//
//        shouldSetupConstraints = false
//      }
//
//      updateViewConstraints()
//    }
}



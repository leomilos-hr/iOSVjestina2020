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
    var button_a = CustomButton()
    var button_b =  CustomButton()
    var button_c =  CustomButton()
    var button_d =  CustomButton()
    var button_exit =  CustomButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addCustomView() {
        qlabel.backgroundColor=UIColor.white
        qlabel.numberOfLines = 0
        qlabel.frame = CGRect(x: 0,y: 0,width: self.frame.width, height: self.frame.height / 8)
        qlabel.textAlignment = NSTextAlignment.center
        self.addSubview(qlabel)
        
        button_a.frame = CGRect(x: 0,y: self.frame.height / 8,width: self.frame.width, height: self.frame.height / 8)
        self.addSubview(button_a)
        
        button_b.frame = CGRect(x: 0,y: self.frame.height * 2/8,width: self.frame.width, height: self.frame.height / 8)
        self.addSubview(button_b)
        
        button_c.frame = CGRect(x: 0,y: self.frame.height * 3/8,width: self.frame.width, height: self.frame.height / 8)
        self.addSubview(button_c)
        
        button_d.frame = CGRect(x: 0,y: self.frame.height * 4/8,width: self.frame.width, height: self.frame.height / 8)
        self.addSubview(button_d)
        
        button_exit.frame = CGRect(x: 0,y: self.frame.height * 5/8,width: self.frame.width, height: self.frame.height / 8)
        self.addSubview(button_exit)
        
        self.backgroundColor = .white

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

class CustomButton: UIButton {

    var myValue: Int
    var question: Question
    var numberOfQuestions: Int
    var currentQuestion : Int

    override init(frame: CGRect) {
        // set myValue before super.init is called
        self.myValue = 0
        self.question = Question(id: 0, question: "", answers: [], correct_answer: 0)
        self.numberOfQuestions = 0
        self.currentQuestion = 0

        super.init(frame: frame)

        // set other operations after super.init, if required
        backgroundColor = .blue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



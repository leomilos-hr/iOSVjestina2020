//
//  MainQuizScreenView.swift
//  QuizApp
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import PureLayout

class MainQuizScreenView: UIView {

    var shouldSetupConstraints = false

    var quizTitle : UILabel = UILabel()
    var imageQuiz : UIImageView = UIImageView()
    var startQuizButton = UIButton()
    var questionScrollView : UIScrollView = UIScrollView()

    override init(frame: CGRect) {
       super.init(frame: frame)
       setup()
       updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
    }

    func setup(){
        backgroundColor = .darkGray
        quizTitle.numberOfLines = 0
        quizTitle.textAlignment = .center
        quizTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        quizTitle.textColor = .white
        self.addSubview(quizTitle)
        self.addSubview(imageQuiz)
        startQuizButton.setTitle("Start Quiz", for: .normal)
        startQuizButton.backgroundColor = .orange
        startQuizButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(startQuizButton)
        self.addSubview(questionScrollView)
        questionScrollView.backgroundColor = .white
        questionScrollView.isHidden = true
        backgroundSetup()
    }
    
    func backgroundSetup(){
        let background = UIImage(named: "background2.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = self.center
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
    }

    override func updateConstraints() {
    if(!shouldSetupConstraints) {
       quizTitle.autoSetDimensions(to: CGSize(width:  self.frame.width / 2, height: self.frame.height / 15))
       quizTitle.autoPinEdge(toSuperviewEdge: .top, withInset: self.frame.width / 3)
       quizTitle.autoAlignAxis(.vertical, toSameAxisOf: self)
       
       imageQuiz.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 8))
       imageQuiz.autoPinEdge(.top, to: .bottom, of: quizTitle, withOffset: self.frame.size.height / 30)
       imageQuiz.autoAlignAxis(.vertical, toSameAxisOf: self)
       
       startQuizButton.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 15))
       startQuizButton.autoPinEdge(.top, to: .bottom, of: imageQuiz, withOffset: self.frame.size.height / 30)
       startQuizButton.autoAlignAxis(.vertical, toSameAxisOf: self)
        
       questionScrollView.autoSetDimensions(to: CGSize(width:  self.frame.width, height: self.frame.height))
       
       shouldSetupConstraints = true
    }
       super.updateConstraints()
    }


}

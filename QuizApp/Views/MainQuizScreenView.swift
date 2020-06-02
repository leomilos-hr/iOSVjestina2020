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
    var startQuizButton = makeButton(title: "Start Quiz", titleColor: .black, background: .green, borderColor: .black)
    var questionScrollView : UIScrollView = UIScrollView()
    //var questionView: [QuestionView?] = []

    override init(frame: CGRect) {
       super.init(frame: frame)
       setup()
       updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
    }

    func setup(){
        backgroundColor = .white
        quizTitle.numberOfLines = 0
        quizTitle.textAlignment = .center
        self.addSubview(quizTitle)
        self.addSubview(imageQuiz)
        self.addSubview(startQuizButton)
        self.addSubview(questionScrollView)
        questionScrollView.backgroundColor = .white
        questionScrollView.isHidden = true
        //questionView[0] = QuestionView(frame: self.frame)
        //questionScrollView.addSubview(questionView[0]!)
    }

    override func updateConstraints() {
    if(!shouldSetupConstraints) {
       quizTitle.autoSetDimensions(to: CGSize(width:  self.frame.width / 2, height: self.frame.height / 15))
       quizTitle.autoPinEdge(toSuperviewEdge: .top, withInset: self.frame.width / 2 - 100)
       quizTitle.autoAlignAxis(.vertical, toSameAxisOf: self)
       
       imageQuiz.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 10))
       imageQuiz.autoPinEdge(.top, to: .bottom, of: quizTitle, withOffset: 30)
       imageQuiz.autoAlignAxis(.vertical, toSameAxisOf: self)
       
       startQuizButton.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 15))
       startQuizButton.autoPinEdge(.top, to: .bottom, of: imageQuiz, withOffset: 30)
       startQuizButton.autoAlignAxis(.vertical, toSameAxisOf: self)
        
       questionScrollView.autoSetDimensions(to: CGSize(width:  self.frame.width, height: self.frame.height))
       
       shouldSetupConstraints = true
    }
       super.updateConstraints()
    }


}

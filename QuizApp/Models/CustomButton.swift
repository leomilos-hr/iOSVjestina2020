//
//  CustomButton.swift
//  QuizApp
//
//  Created by five on 05/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    var myValue: Int
    var question: Question
    var numberOfQuestions: Int
    var currentQuestion : Int

    override init(frame: CGRect) {
        self.myValue = 0
        self.question = Question(id: 0, question: "", answers: [], correct_answer: 0)
        self.numberOfQuestions = 0
        self.currentQuestion = 0

        super.init(frame: frame)
        backgroundColor = .blue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

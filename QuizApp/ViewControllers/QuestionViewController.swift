//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var quiz: Quiz!
    var currentQuestion: Int!
    var questionView: QuestionView!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
      
    }
    
    func setupView(){
        let mainView = QuestionView(frame: self.view.frame)
        self.questionView = mainView
        self.view.addSubview(questionView)
        questionView.qlabel.text = quiz.questions[currentQuestion].question
               
        for (index, button) in [questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d].enumerated(){
            button.setTitle(quiz.questions[currentQuestion].answers[index], for: .normal)
        }
        questionView.button_exit.setTitle("Izlaz", for: .normal)
       
               
        for button in [questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d, questionView.button_exit]{
            button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        }
        //self.questionView.loginButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    }
    
    
    @objc func buttonAction(_sender: UIButton!){
         if _sender == questionView.button_exit{
            let vc = ViewController()
            self.navigationController?.pushViewController(vc, animated: true)
         }
         
         for (index, answers) in quiz.questions[currentQuestion].answers.enumerated(){
             if (_sender.currentTitle == answers){
                if (index == quiz.questions[currentQuestion].correct_answer ){
                    _sender.backgroundColor = UIColor.green
                    if currentQuestion < quiz.questions.count - 1 {
                        let qvc = QuestionViewController()
                        qvc.quiz = quiz
                        qvc.currentQuestion = currentQuestion + 1
                        self.navigationController?.pushViewController(qvc, animated: true)
                    }
                 }
                 else{
                     _sender.backgroundColor = UIColor.red
                 }
            }
        }
    }
    
}

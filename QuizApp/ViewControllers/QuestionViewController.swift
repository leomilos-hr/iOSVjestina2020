//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var question: Question!
    var questionView: QuestionView!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
      
    }
    
    func setupView(){
        let mainView = QuestionView(frame: self.view.frame)
        self.questionView = mainView
        self.view.addSubview(questionView)
        questionView.qlabel.text = question.question
               
        for (index, button) in [questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d].enumerated(){
            button.setTitle(question.answers[index], for: .normal)
        }
        questionView.button_exit.setTitle("Izlaz", for: .normal)
       
               
        for button in [questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d, questionView.button_exit]{
            button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        }
        //self.questionView.loginButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
    }

       @objc func buttonAction(_sender: UIButton!){
         if _sender == questionView.button_exit{
             self.navigationController?.popViewController(animated: true)
         }
         
         for (index, answers) in question.answers.enumerated(){
             if (_sender.currentTitle == answers){
                 if (index == question.correct_answer){
                      _sender.backgroundColor = UIColor.green
                 }
                 else{
                     _sender.backgroundColor = UIColor.red
                 }
            }
        }
    }
}

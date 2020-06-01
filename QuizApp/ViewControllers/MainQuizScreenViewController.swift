//
//  MainQuizScreenViewController.swift
//  QuizApp
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class MainQuizScreenViewController: UIViewController {

    var chosenQuiz: Quiz!
    var currentQuestion : Int = 0
    var mqs: MainQuizScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
    }

    func setupView(){
        let mainView = MainQuizScreenView(frame: self.view.frame)
        self.mqs = mainView
        self.view.addSubview(mqs)
        mqs.quizTitle.text = chosenQuiz.title
        mqs.startQuizButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        let imageUrl = URL(string: chosenQuiz.image)
        let dataImage = try? Data(contentsOf: imageUrl!)
        if let imageCheck = dataImage {
            mqs.imageQuiz.image = UIImage(data: imageCheck)
        }
        
        mqs.questionView.qlabel.text = chosenQuiz.questions[currentQuestion].question
               
        for (index, button) in [ mqs.questionView.button_a, mqs.questionView.button_b, mqs.questionView.button_c, mqs.questionView.button_d].enumerated(){
            button.setTitle(chosenQuiz.questions[currentQuestion].answers[index], for: .normal)
        }
          mqs.questionView.button_exit.setTitle("Izlaz", for: .normal)
        
        for button in [mqs.questionView.button_a, mqs.questionView.button_b, mqs.questionView.button_c, mqs.questionView.button_d, mqs.questionView.button_exit]{
            button.addTarget(self, action: #selector(self.buttonAction2), for: .touchUpInside)
        }
    }
    
    @objc func buttonAction2(_sender: UIButton!){
            if _sender == mqs.questionView.button_exit{
               self.navigationController?.popViewController(animated: true)
            }
            
            for (index, answers) in chosenQuiz.questions[currentQuestion].answers.enumerated(){
                if (_sender.currentTitle == answers){
                   if (index == chosenQuiz.questions[currentQuestion].correct_answer ){
                       _sender.backgroundColor = UIColor.green
                        currentQuestion += 1
                       if currentQuestion < chosenQuiz.questions.count {
                            mqs.questionView.qlabel.text = chosenQuiz.questions[currentQuestion].question
                                      
                            for (index, button) in [ mqs.questionView.button_a, mqs.questionView.button_b, mqs.questionView.button_c, mqs.questionView.button_d].enumerated(){
                                button.setTitle(chosenQuiz.questions[currentQuestion].answers[index], for: .normal)
                                button.backgroundColor = .blue
                            }
                            mqs.questionView.button_exit.setTitle("Izlaz", for: .normal)
//                           let qvc = QuestionViewController()
//                           qvc.quiz = chosenQuiz
//                           qvc.currentQuestion = currentQuestion + 1
//                           self.navigationController?.pushViewController(qvc, animated: true)
                       }
                        if currentQuestion == chosenQuiz.questions.count {
                             self.navigationController?.popViewController(animated: true)
                            }
                    }
                    else{
                        _sender.backgroundColor = UIColor.red
                    }
               }
           }
       }


    @objc func buttonAction(_sender: UIButton!){
     //if _sender == questionView.button_exit{
     //    self.navigationController?.popViewController(animated: true)
     //}
        //let qvc = QuestionViewController()
//        qvc.quiz = chosenQuiz
//        qvc.currentQuestion = currentQuestion
//        self.navigationController?.pushViewController(qvc, animated: true)
//
        self.mqs.questionScrollView.isHidden = false
        
    }

}

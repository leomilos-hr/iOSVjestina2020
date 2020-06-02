//
//  MainQuizScreenViewController.swift
//  QuizApp
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class MainQuizScreenViewController: UIViewController, UIScrollViewDelegate {

    var chosenQuiz: Quiz!
    var currentQuestion : Int = 0
    var mqs: MainQuizScreenView!
    var pageControl: UIPageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
        setupSlideScrollView()
        mqs.questionScrollView.delegate = self
        pageControl.numberOfPages = 10
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
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
        
        
        
        
    }
    
//    @objc func buttonAction2(_sender: UIButton!){
//            if _sender == mqs.questionView.button_exit{
//               self.navigationController?.popViewController(animated: true)
//            }
//
//            for (index, answers) in chosenQuiz.questions[currentQuestion].answers.enumerated(){
//                if (_sender.currentTitle == answers){
//                   if (index == chosenQuiz.questions[currentQuestion].correct_answer ){
//                       _sender.backgroundColor = UIColor.green
//                        currentQuestion += 1
//                       if currentQuestion < chosenQuiz.questions.count {
//                            mqs.questionView.qlabel.text = chosenQuiz.questions[currentQuestion].question
//
//                            for (index, button) in [ mqs.questionView.button_a, mqs.questionView.button_b, mqs.questionView.button_c, mqs.questionView.button_d].enumerated(){
//                                button.setTitle(chosenQuiz.questions[currentQuestion].answers[index], for: .normal)
//                                button.backgroundColor = .blue
//                            }
//                            mqs.questionView.button_exit.setTitle("Izlaz", for: .normal)
////                           let qvc = QuestionViewController()
////                           qvc.quiz = chosenQuiz
////                           qvc.currentQuestion = currentQuestion + 1
////                           self.navigationController?.pushViewController(qvc, animated: true)
//                       }
//                        if currentQuestion == chosenQuiz.questions.count {
//                             self.navigationController?.popViewController(animated: true)
//                            }
//                    }
//                    else{
//                        _sender.backgroundColor = UIColor.red
//                    }
//               }
//           }
//       }


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
    
    func setupSlideScrollView() {
        var w: CGFloat = 0
        //self.mqs.questionScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: //view.frame.height)
        self.mqs.questionScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mqs.questionScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(chosenQuiz.questions.count), height: view.frame.height)
        self.mqs.questionScrollView.isPagingEnabled = true
        
        for (index, ques) in chosenQuiz.questions.enumerated(){
            let questionView = QuestionView(frame: self.view.frame)
            questionView.qlabel.text = ques.question
                   
            for (index, button) in [ questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d].enumerated(){
                button.setTitle(ques.answers[index], for: .normal)
            }
              questionView.button_exit.setTitle("Izlaz", for: .normal)
            
            questionView.sizeToFit()
            questionView.frame.origin = CGPoint(x: w,y: 0)
            w += view.frame.width
            
            //mqs.questionScrollView.setContentOffset(CGPoint(x: view.frame.width, y: 0), animated: true)
            
            for button in [questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d, questionView.button_exit]{
                button.addTarget(self, action: #selector(self.buttonAction2), for: .touchUpInside)
                button.question = ques
                button.numberOfQuestions = chosenQuiz.questions.count
                button.currentQuestion = index
            }
            
             mqs.questionScrollView.addSubview(questionView)

        }
    }
    
    var nextScreen : CGFloat = 0
    
    @objc func buttonAction2(_sender: CustomButton!){
        if _sender.currentTitle == "Izlaz"{
            self.navigationController?.popViewController(animated: true)
         }
        for (index, answers) in _sender.question.answers.enumerated(){
             if (_sender.currentTitle == answers){
                if (index == _sender.question.correct_answer ){
                    _sender.backgroundColor = UIColor.green
                    nextScreen += view.frame.width
                    if _sender.currentQuestion < _sender.numberOfQuestions - 1 {
                         mqs.questionScrollView.setContentOffset(CGPoint(x: nextScreen, y: 0), animated: true)
                    }
                    else{
                         self.navigationController?.popViewController(animated: true)
                    }
                 }
                 else{
                     _sender.backgroundColor = UIColor.red
                 }
            }
        }
    }

}

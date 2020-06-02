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
    var start : Date?
    var questionsAnsweredCorrectly : Int = 0
    
    
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

    @objc func buttonAction(_sender: UIButton!){
        self.mqs.questionScrollView.isHidden = false
        start = Date()
    }
    
    func setupSlideScrollView() {
        var w: CGFloat = 0
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
                    questionsAnsweredCorrectly += 1
                 }
                 else{
                     _sender.backgroundColor = UIColor.red
                    
                }
                
                nextScreen += view.frame.width
                if _sender.currentQuestion < _sender.numberOfQuestions - 1 {
                    mqs.questionScrollView.setContentOffset(CGPoint(x: nextScreen, y: 0), animated: true)
                }
                else{
                  print("Elapsed time: \(start!.timeIntervalSinceNow * -1) seconds")
                  print("Questions answered correctly: \(questionsAnsweredCorrectly)")
                   self.navigationController?.popViewController(animated: true)
              }
                
            }
        }
    }
}

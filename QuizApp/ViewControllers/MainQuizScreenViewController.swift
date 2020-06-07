//
//  MainQuizScreenViewController.swift
//  QuizApp
//
//  Created by five on 01/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import Alamofire

class MainQuizScreenViewController: UIViewController {

    var nextScreen : CGFloat = 0
    var chosenQuiz: Quiz!
    var currentQuestion : Int = 0
    var mqs: MainQuizScreenView!
    var start : Date?
    var questionsAnsweredCorrectly : Int = 0
    var elapsedTime : Double!
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
        setupSlideScrollView()
    }

    func setupView(){
        mqs = MainQuizScreenView(frame: self.view.frame)
        view.addSubview(mqs)
        mqs.quizTitle.text = chosenQuiz.title
        mqs.startQuizButton.addTarget(self, action: #selector(self.showQuiz), for: .touchUpInside)
        let imageUrl = URL(string: chosenQuiz.image)
        let dataImage = try? Data(contentsOf: imageUrl!)
        if let imageCheck = dataImage {
            mqs.imageQuiz.image = UIImage(data: imageCheck)
        }
    }

    func setupSlideScrollView() {
        var w: CGFloat = 0
        self.mqs.questionScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mqs.questionScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(chosenQuiz.questions.count), height: view.frame.height)
        self.mqs.questionScrollView.isPagingEnabled = true
        
        for (index, question) in chosenQuiz.questions.enumerated(){
            let questionView = QuestionView(frame: self.view.frame)
            questionView.qlabel.text = question.question
                   
            for (index, button) in [ questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d].enumerated(){
                button.setTitle(question.answers[index], for: .normal)
            }
            questionView.button_exit.setTitle("Exit", for: .normal)
            
            questionView.sizeToFit()
            questionView.frame.origin = CGPoint(x: w,y: 0)
            w += view.frame.width
            
            for button in [questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d]{
                button.addTarget(self, action: #selector(self.questionAction), for: .touchUpInside)
                button.question = question
                button.numberOfQuestions = chosenQuiz.questions.count
                button.currentQuestion = index
            }
            questionView.button_exit.addTarget(self, action: #selector(self.exitAction), for: .touchUpInside)
            
            mqs.questionScrollView.addSubview(questionView)

        }
    }
    
    @objc func showQuiz(_sender: UIButton!){
        self.mqs.questionScrollView.isHidden = false
        start = Date()
    }
    
   @objc func exitAction(_sender: CustomButton!){
        self.navigationController?.popViewController(animated: true)
    }
   
    
    @objc func questionAction(_sender: CustomButton!){
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
                    elapsedTime = start!.timeIntervalSinceNow * -1
                    print("Elapsed time: \(start!.timeIntervalSinceNow * -1) seconds")
                    print("Questions answered correctly: \(questionsAnsweredCorrectly)")
                    let parameters: [String: Any] = [
                        "quiz_id": chosenQuiz.id,
                        "user_id": defaults.object(forKey: "user_id")!,
                        "time": elapsedTime!,
                        "no_of_correct": questionsAnsweredCorrectly
                    ]
                    let headers: HTTPHeaders = [
                        .authorization(defaults.object(forKey: "token") as! String),
                        .accept("application/json")
                    ]
                   
                    AF.request("https://iosquiz.herokuapp.com/api/result", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<300)
                        .responseJSON { response in
                            //print(response)
                            switch response.result {
                                case .success:
                                    print("Status code: \(response.response!.statusCode)")
                                    //debugPrint(response)
                                    self.navigationController?.popViewController(animated: true)
                                case .failure:
                                    print("Status code: \(response.response!.statusCode)")
                                    //debugPrint(response)
                            }
                        }
                }
                
            }
        }
    }
}

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
        
        for (index, question) in chosenQuiz.questions.enumerated(){
            let questionView = QuestionView(frame: self.view.frame)
            questionView.qlabel.text = question.question
                   
            for (index, button) in [ questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d].enumerated(){
                button.setTitle(question.answers[index], for: .normal)
            }
            questionView.button_exit.setTitle("Izlaz", for: .normal)
            
            questionView.sizeToFit()
            questionView.frame.origin = CGPoint(x: w,y: 0)
            w += view.frame.width
            
            for button in [questionView.button_a, questionView.button_b, questionView.button_c, questionView.button_d, questionView.button_exit]{
                button.addTarget(self, action: #selector(self.buttonAction2), for: .touchUpInside)
                button.question = question
                button.numberOfQuestions = chosenQuiz.questions.count
                button.currentQuestion = index
            }
            
             mqs.questionScrollView.addSubview(questionView)

        }
    }
    
   
    
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
                   
                    AF.request("https://iosquiz.herokuapp.com/api/result", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
               .responseJSON { response in
                   print(response)
                   switch response.result {
                       case .success:
                            debugPrint(response)
                            self.navigationController?.popViewController(animated: true)
                       case .failure(let error):
                           print(error)
                            debugPrint(response)
                        
                       }
                   }
              }
                
            }
        }
    }
}

//
//  ViewController.swift
//  QuizApp
//
//  Created by five on 10/04/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

struct Quizzes: Codable {
    let quizzes: [Quiz]
}

struct Quiz: Codable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let level: Int
    let image: String
    let questions:[Question]
    
    enum CodingKeys: String, CodingKey {
            case id = "id" // naziv u navodnicima mora biti jednak json definiciji varijable
            case title = "title"
            case description = "description"
            case category = "category"
            case level = "level"
            case image = "image"
            case questions = "questions"
    }
}

struct Question: Codable {
    let id: Int
    let question: String
    let answers: [String]
    let correct_answer: Int
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case question = "question"
            case answers = "answers"
            case correct_answer = "correct_answer"

    }
}



class ViewController: UIViewController {
    @IBOutlet weak var fun_fact: UILabel!
    
    @IBAction func dohvati(_ sender: UIButton) {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else {return}
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                    error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let list_of_quizzes = try decoder.decode(Quizzes.self, from: data)
                    //print(list_of_quizzes.quizzes[0].questions[0].id)
                    
                    /*for quiz in list_of_quizzes.quizzes {
                        for question_i in quiz.questions{
                            if question_i.question.contains("NBA"){
                                //print(question_i.question)
                                sum_of_questions_containing_NBA += 1
                            }
                        }
                    }*/
                    
                    let sum_of_questions_containing_NBA: Int = list_of_quizzes.quizzes.map{$0.questions.filter{$0.question.contains("NBA")}}.count
                    //print("Ukupno pitanja koja u tekstu pitanja sadrže riječ “NBA”: \(sum_of_questions_containing_NBA)")
                    
                    DispatchQueue.main.async { // Correct
                       self.fun_fact.text = "Ukupno pitanja koja u tekstu pitanja sadrže riječ “NBA”: \(sum_of_questions_containing_NBA)"
                    }
                    
                 } catch let parsingError {
                    print("Error", parsingError)
               }
            }
            task.resume()
        
        }
        
}







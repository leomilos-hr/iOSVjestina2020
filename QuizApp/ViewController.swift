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

struct Questions: Codable {
    let id: Int
    let question: String
    let answers: [String]
    let correct_answer: Int
}

struct Quiz: Codable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let level: Int
    let image: String
    let questions:[Questions]
    
    /*enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case description = "description"
            case category = "category"
            case level = "level"
            case image = "image"
            case questions = "questions"
    }*/
}

class ViewController: UIViewController {
    @IBOutlet weak var u: UITextField!
    @IBOutlet weak var p: UITextField!
    @IBAction func signIn(_ sender: Any) {
        //print("hello")
        //print("\(u.text!)")
        //print("\(p.text!)")

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
                print(list_of_quizzes.quizzes[0].title)
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()

    }
}






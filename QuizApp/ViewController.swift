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

class Alert {
    
    class func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var fun_fact: UILabel!
    @IBOutlet weak var image_v: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonDohvati: UIButton!
    
    override func viewDidLoad() {
        tableView.delegate = self;
        tableView.dataSource = self;
        
        super.viewDidLoad()
        
    }
    
    var mySubview: CustomView!
    var myErrorSubview: ErrorView!
    
    var imagesQuiz: [UIImage] = []
    var titlesQuiz: [String] = []
    var categoryQuiz: [String] = []
    var questionsQuiz: [[Question]] = []
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesQuiz.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        //cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.quizImage.layer.cornerRadius = cell.quizImage.frame.height / 2
        
        
        cell.quizLabel.text = titlesQuiz[indexPath.row]
        cell.quizImage.image = imagesQuiz[indexPath.row]
        switch categoryQuiz[indexPath.row] {
            case "SCIENCE":
                cell.cellView.backgroundColor = UIColor.orange
            case "SPORTS":
                cell.cellView.backgroundColor = UIColor.blue
            default:
                cell.cellView.backgroundColor = UIColor.red
        }
        cell.quizLabel.textColor = UIColor.white
        return cell
    }
    
    var randomQuestion: Question?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.buttonDohvati.isEnabled = false
        
        let selectedIndex = indexPath.row
        mySubview = CustomView(frame: CGRect(x: self.view.frame.size.width  / 2,
                                                             y: self.view.frame.size.height / 2,
                                                             width: self.view.frame.size.width  * 4/5,
                                                             height: self.view.frame.size.height * 3/4))
        mySubview.center = CGPoint(x: self.view.bounds.midX,
        y: self.view.bounds.midY);
        //mySubview.qLabel.lineBreakMode = .byWordWrapping
        mySubview.qLabel.numberOfLines = 0;
        mySubview.qLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(mySubview)
        //mySubview.qLabel.text = titlesQuiz[selectedIndex]
        randomQuestion = questionsQuiz[selectedIndex].randomElement()!
        mySubview.qLabel.text = randomQuestion!.question
        mySubview.button_a.setTitle(randomQuestion!.answers[0], for: .normal)
        mySubview.button_b.setTitle(randomQuestion!.answers[1], for: .normal)
        mySubview.button_c.setTitle(randomQuestion!.answers[2], for: .normal)
        mySubview.button_d.setTitle(randomQuestion!.answers[3], for: .normal)
        mySubview.button_exit.setTitle("Izlaz", for: .normal)
        mySubview.button_a.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        mySubview.button_b.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        mySubview.button_c.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        mySubview.button_d.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        mySubview.button_exit.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.isUserInteractionEnabled = false
    }
    
    @objc func buttonAction(_sender: UIButton){
        if _sender == mySubview.button_exit{
            mySubview.removeFromSuperview()
        }
        if _sender == mySubview.button_a{
            if randomQuestion!.answers[randomQuestion!.correct_answer] == randomQuestion!.answers[0] {
                _sender.backgroundColor = UIColor.green
            }
            else{
                _sender.backgroundColor = UIColor.red
            }
        }
        if _sender == mySubview.button_b{
            if randomQuestion!.answers[randomQuestion!.correct_answer] == randomQuestion!.answers[1] {
                _sender.backgroundColor = UIColor.green
            }
            else{
                _sender.backgroundColor = UIColor.red
            }
        }
        if _sender == mySubview.button_c{
            if randomQuestion!.answers[randomQuestion!.correct_answer] == randomQuestion!.answers[2] {
                _sender.backgroundColor = UIColor.green
            }
            else{
                _sender.backgroundColor = UIColor.red
            }
        }
        if _sender == mySubview.button_d{
            if randomQuestion!.answers[randomQuestion!.correct_answer] == randomQuestion!.answers[3] {
                _sender.backgroundColor = UIColor.green
            }
            else{
                _sender.backgroundColor = UIColor.red
            }
        }
        self.buttonDohvati.isEnabled = true
        self.tableView.isUserInteractionEnabled = true
       }
    
    @IBAction func dohvati(_ sender: UIButton) {
        self.buttonDohvati.isEnabled = false
        self.titlesQuiz.removeAll()
        self.imagesQuiz.removeAll()
        
        
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else {return}
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, !data.isEmpty else{
                    DispatchQueue.main.async {
                        Alert.showBasic(title: "Greška", message: "Greška u dohvaćanju sa servera", vc: self)
                    }
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
                        
                        for quiz in list_of_quizzes.quizzes{
                            let url = URL(string: quiz.image)
                            let data = try? Data(contentsOf: url!)

                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                self.imagesQuiz.append(image!)
                           }
                            self.titlesQuiz.append(quiz.title)
                            self.categoryQuiz.append(quiz.category)
                            var list_ques : [Question] = []
                            for ques in quiz.questions{
                                list_ques.append(ques)
                            }
                            self.questionsQuiz.append(list_ques)
                        }
                        
                        //print(self.titlesQuiz.count)
                        //print(self.imagesQuiz.count)
                        
                        self.tableView.reloadData()
                    
                        self.buttonDohvati.isEnabled = true
                        
                    }
        
                 } catch let parsingError {
                    DispatchQueue.main.async {
                        Alert.showBasic(title: "Greška", message: "Greška u parsiranju podataka", vc: self)
                    }
                    print("Error", parsingError)
               }
            }
            task.resume()

        
        }

}

//
//  ViewController.swift
//  QuizApp
//
//  Created by five on 10/04/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var fun_fact: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonDohvati: UIButton!
    
    var list_of_quizzes = Quizzes(quizzes:[])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    var mySubview: CustomView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_of_quizzes.quizzes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.quizImage.layer.cornerRadius = cell.quizImage.frame.height / 2
        
        cell.quizLabel.text = list_of_quizzes.quizzes[indexPath.row].title
        
        let imageUrl = URL(string: list_of_quizzes.quizzes[indexPath.row].image)
        let dataImage = try? Data(contentsOf: imageUrl!)
        if let imageCheck = dataImage {
            cell.quizImage.image = UIImage(data: imageCheck)
        }
        
        //kategorija kviza
        switch list_of_quizzes.quizzes[indexPath.row].category{
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
        mySubview.qLabel.numberOfLines = 0;
        mySubview.qLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(mySubview)
        
        randomQuestion = list_of_quizzes.quizzes[selectedIndex].questions.randomElement()!
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
        
        //initilazition of service
        let service = Service(baseUrl: "https://iosquiz.herokuapp.com/api/")
            service.getAllQuizzes(endPoint: "quizzes")
            service.completionHandler { [weak self] (quizzes, status, message) in
            if status {
                guard let self = self else {return}
                guard let _quizzes = quizzes else {return}
                self.list_of_quizzes = _quizzes
                let sum_of_questions_containing_NBA: Int = self.list_of_quizzes.quizzes.map{$0.questions.filter{$0.question.contains("NBA")}}.count
                self.fun_fact.text = "Ukupno pitanja koja u tekstu pitanja sadrže riječ “NBA”: \(sum_of_questions_containing_NBA)"
                self.tableView.reloadData()
            }
            else {
                print(message)
                Alert.showBasic(title: "Greška", message: "Greška u dohvaćanju podataka", vc: self!)
                }
        }
        
        self.buttonDohvati.isEnabled = true
    }
}

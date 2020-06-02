//
//  ViewController.swift
//  QuizApp
//
//  Created by five on 10/04/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import Alamofire
import PureLayout


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var didSetupConstraints = false
    var fun_fact = UILabel()
    let button_get = makeButton(title: "Dohvati", background: .green)
    var tableView = UITableView()
    var mySubview: QuestionView!
    
    var list_of_quizzes = Quizzes(quizzes:[])
    var categoriesList: [String] = []
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        button_get.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = categoriesList[section]
        label.textAlignment = .center
        switch categoriesList[section]{
           case "SCIENCE":
               label.backgroundColor = UIColor.orange
           case "SPORTS":
               label.backgroundColor = UIColor.blue
           default:
               label.backgroundColor = UIColor.red
        }
        label.textColor = UIColor.white
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return self.view.frame.height / 8
     }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height / 16
    }
      
    func numberOfSections(in tableView: UITableView) -> Int {
        for quiz in list_of_quizzes.quizzes{
            if !categoriesList.contains(quiz.category){
                categoriesList.append(quiz.category)
            }
        }
        return categoriesList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter : Int = 0
        for quiz in list_of_quizzes.quizzes{
            if quiz.category == categoriesList[section]{
                counter += 1
            }
        }
        return counter
    }
    
    var titlesQuiz : [String] = []
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = CustomTableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        
        var quizForCell : Quiz!

        for quiz in list_of_quizzes.quizzes{
            if quiz.category == categoriesList[indexPath.section] && !titlesQuiz.contains(quiz.title){
                titlesQuiz.append(quiz.title)
                quizForCell = quiz
                break
            }
        }

        cell.contentView.addSubview(cell.textLevel)
        cell.textLabel?.text = quizForCell.title
        cell.textLabel?.numberOfLines = 1
        cell.textLabel?.sizeToFit()
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.text = quizForCell.description
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.sizeToFit()
        cell.detailTextLabel?.textAlignment = .left
        
        cell.textLevel.textColor = .green
        cell.textLevel.font = UIFont.boldSystemFont(ofSize: 30)
        cell.textLevel.textAlignment = .right
        
        var numberOfStars: String = ""
        for _ in (1...quizForCell.level){
            numberOfStars += "*"
        }
        cell.textLevel.text = numberOfStars
        
        let imageUrl = URL(string: quizForCell.image)
        let dataImage = try? Data(contentsOf: imageUrl!)
        if let imageCheck = dataImage {
            cell.imageView?.image = UIImage(data: imageCheck)
        }
        
        //kategorija kviza
        switch quizForCell.category{
            case "SCIENCE":
                cell.backgroundColor = UIColor.orange
            case "SPORTS":
                cell.backgroundColor = UIColor.blue
            default:
                cell.backgroundColor = UIColor.red
        }

        return cell
    }
    
    var randomQuestion: Question!

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.button_get.isEnabled = false
        self.tableView.isUserInteractionEnabled = false

//        mySubview = QuestionView(frame: CGRect(x: self.view.frame.size.width  / 2,
//                                                             y: self.view.frame.size.height / 2,
//                                                             width: self.view.frame.size.width  * 4/5,
//                                                             height: self.view.frame.size.height * 3/4))
//        mySubview.center = CGPoint(x: self.view.bounds.midX,
//        y: self.view.bounds.midY);
//        mySubview.qlabel.numberOfLines = 0;
//        mySubview.qlabel.adjustsFontSizeToFitWidth = true
//        self.view.addSubview(mySubview)
        
        let cell = self.tableView.cellForRow(at: indexPath)
        
        //print(cell!.textLabel!.text!)
        
        var quizForCell : Quiz!
        for quiz in list_of_quizzes.quizzes{
            if quiz.title == cell!.textLabel!.text!{
                quizForCell = quiz
                break
            }
        }
        
        let mqsvc = MainQuizScreenViewController()
        mqsvc.chosenQuiz = quizForCell
        self.navigationController?.pushViewController(mqsvc, animated: true)

//        randomQuestion = quizForCell.questions.randomElement()!
//        mySubview.qlabel.text = randomQuestion!.question
//
//        for (index, button) in [mySubview.button_a, mySubview.button_b, mySubview.button_c, mySubview.button_d].enumerated(){
//            button.setTitle(randomQuestion!.answers[index], for: .normal)
//        }
//        mySubview.button_exit.setTitle("Izlaz", for: .normal)
//
//
//        for button in [mySubview.button_a, mySubview.button_b, mySubview.button_c, mySubview.button_d, mySubview.button_exit]{
//           button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
//        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.isUserInteractionEnabled = true
        self.button_get.isEnabled = true
    }

//    @objc func buttonAction(_sender: UIButton!){
//        if _sender == mySubview.button_exit{
//            mySubview.removeFromSuperview()
//            self.button_get.isEnabled = true
//            self.tableView.isUserInteractionEnabled = true
//        }
//
//        for (index, answers) in randomQuestion!.answers.enumerated(){
//            if (_sender.currentTitle == answers){
//                if (index == randomQuestion?.correct_answer){
//                     _sender.backgroundColor = UIColor.green
//                }
//                else{
//                    _sender.backgroundColor = UIColor.red
//                }
//            }
//        }
//    }
    
    @objc func buttonClicked(_ sender: UIButton!){
        //let loginViewController = LoginViewController()
        //navigationController?.pushViewController(loginViewController, animated: true)
        self.button_get.isEnabled = false
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
                self.titlesQuiz.removeAll()
            }
            else {
                print(message)
                Alert.showBasic(title: "Greška", message: "Greška u dohvaćanju podataka", vc: self!)
            }
        }
   
        self.button_get.isEnabled = true
    }
}

// MARK: PureLayout Implementation
extension ViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white
        view.addSubview(button_get)
        fun_fact.text = "Fun Fact"
        fun_fact.numberOfLines = 0
        view.addSubview(fun_fact)
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            button_get.autoSetDimensions(to: CGSize(width: self.view.frame.width / 2, height: self.view.frame.size.height / 10))
            button_get.autoPinEdge(toSuperviewEdge: .top, withInset: self.view.frame.height / 20)
            button_get.autoAlignAxis(.vertical, toSameAxisOf: self.view)
            
            fun_fact.autoPinEdge(.top, to: .bottom, of: button_get, withOffset: self.view.frame.height / 30)
            fun_fact.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
            fun_fact.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
            
            tableView.autoSetDimensions(to: CGSize(width: self.view.frame.width, height: self.view.frame.size.height))
            tableView.autoPinEdge(.top, to: .bottom, of: fun_fact, withOffset: self.view.frame.height / 30)
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}

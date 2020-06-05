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
    //let button_get = makeButton(title: "Dohvati", background: .green)
    var button_get = UIButton()
    var tableView = UITableView()
    var mySubview: QuestionView!
    var ima1 : NSMutableArray = []
    var constraintsWith = [NSLayoutConstraint]()
    var c1 : NSLayoutConstraint!
    var c2 : NSLayoutConstraint!
   
   
    
    
    var list_of_quizzes = Quizzes(quizzes:[])
    var categoriesList: [String] = []
    var rowCounter : CGFloat = 0
    
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
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
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
                rowCounter += 1
            }
        }
        //print("\(counter)")
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
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        
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
                //self.view.viewWithTag(10)!.removeFromSuperview()
                //self.tableView = UITableView()
                //self.tableView = UITableView()
                
                //self.view.addSubview(self.tableView)

                
           
                self.tableView.reloadData()
                NSLayoutConstraint.deactivate(self.constraintsWith)
                self.constraintsWith = [NSLayoutConstraint]()
                
                
                //self.loadView()
                let heightTableView1 = self.view.frame.height *  self.rowCounter / 8
                let heightTableView2 = self.view.frame.height *  CGFloat(self.categoriesList.count) / 16
                let heightTableView = heightTableView1 + heightTableView2
                self.rowCounter = 0
                self.tableView.autoSetDimensions(to: CGSize(width: self.view.frame.width, height: heightTableView))
                self.c1 = self.tableView.heightAnchor.constraint(equalToConstant: heightTableView)
                self.c2 = self.tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width)
                self.constraintsWith.append(self.c1)
                self.constraintsWith.append(self.c2)
                NSLayoutConstraint.activate(self.constraintsWith)
                self.titlesQuiz.removeAll()
                //ima1.removeObject(at: 0)
                //self.ima1.autoRemoveConstraints()
                //self.tableView = UITableView(frame: CGRect(x:0,y:300,width:self.view.frame.width, height: //self.view.frame.height))
               
                //self.tableView.autoPinEdge(.top, to: .bottom, of: self.fun_fact, withOffset: self.view.frame.height / 30))
                //self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: heightTableView)
                //print("\(heightTableView)")
                //self.tableView.autoSetDimension(.width, to: view.frame.width)
                //self.tableView.autoSetDimension(.height, to: heightTableView)
                //self.tableView.frame = CGRect(x: 0, y: 400, width: self.view.frame.width, height: heightTableView);
                //self.view.addSubview(self.tableView)
              
                //self.tableView.autoPinEdge(.top, to: .bottom, of: self.fun_fact, withOffset: self.view.frame.height / 30)
                
                //self.tableView.autoSetDimensions(to: CGSize(width: self.view.frame.width, height: heightTableView))
                //self.tableView.tag = 10
                //self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: heightTableView)
                
                
            }
            else {
                print(message)
                Alert.showBasic(title: "Greška", message: "Greška u dohvaćanju podataka", vc: self!)
            }
        }
        
           //self.view.setNeedsUpdateConstraints()
        
        self.button_get.isEnabled = true
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white
        button_get.backgroundColor = .green
        button_get.setTitle("Dohvati", for: .normal)
        button_get.setTitleColor(.black, for: .normal)
        view.addSubview(button_get)
        fun_fact.text = "Fun Fact"
        fun_fact.numberOfLines = 0
        view.addSubview(fun_fact)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        //didSetupConstraints = false
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
            
            tableView.autoPinEdge(.top, to: .bottom, of: fun_fact, withOffset: self.view.frame.height / 30)
            c1 = tableView.heightAnchor.constraint(equalToConstant: 0)
            c2 = tableView.widthAnchor.constraint(equalToConstant: view.frame.width)
            constraintsWith.append(c1)
            constraintsWith.append(c2)
            NSLayoutConstraint.activate(constraintsWith)
             
        }
        //didSetupConstraints = true
        super.updateViewConstraints()
    }

    
}

// MARK: PureLayout Implementation
extension ViewController {
    
    
}

//class SelfSizedTableView: UITableView {
//
//  override func reloadData() {
//    super.reloadData()
//    self.invalidateIntrinsicContentSize()
//    self.layoutIfNeeded()
//  }
//
//  override var intrinsicContentSize: CGSize {
//    let height = contentSize.height
//    return CGSize(width: contentSize.width, height: height)
//  }
//}
//

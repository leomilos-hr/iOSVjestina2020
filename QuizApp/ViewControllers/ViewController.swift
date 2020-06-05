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


class ViewController: UIViewController {

    var didSetupConstraints = false
    var fun_fact = UILabel()
    var button_get = UIButton()
    var tableView = UITableView()
    var mySubview: QuestionView!
    var ima1 : NSMutableArray = []
    var constraintsWith = [NSLayoutConstraint]()
    var c1 : NSLayoutConstraint!
    var c2 : NSLayoutConstraint!
    var logoutButton : UIButton = UIButton()
    let defaults = UserDefaults.standard
    var titlesQuiz : [String] = []
    var list_of_quizzes = Quizzes(quizzes:[])
    var categoriesList: [String] = []
    var rowCounter : CGFloat = 0
    var randomQuestion: Question!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        button_get.addTarget(self, action: #selector(getQuizAction(_:)), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logOutAction(_:)), for: .touchUpInside)
    }
    
    @objc func logOutAction(_ sender: UIButton!){
        defaults.removeObject(forKey: "user_id")
        defaults.removeObject(forKey: "token")
        if self.navigationController!.viewControllers.count > 1{
            self.navigationController?.popViewController(animated: true)
        }
        else{
            let viewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.isTranslucent = false
            self.view.window?.rootViewController? = navigationController
        }
    }
    
    @objc func getQuizAction(_ sender: UIButton!){
        //let loginViewController = LoginViewController()
        //navigationController?.pushViewController(loginViewController, animated: true)
        self.button_get.isEnabled = false
        //initilazition of service
        let service = GetQuizService(baseUrl: "https://iosquiz.herokuapp.com/api/")
        service.getAllQuizzes(endPoint: "quizzes")
        service.completionHandler { [weak self] (quizzes, status, message) in
            if status {
                guard let self = self else {return}
                guard let _quizzes = quizzes else {return}
                self.list_of_quizzes = _quizzes
                let sum_of_questions_containing_NBA: Int = self.list_of_quizzes.quizzes.map{$0.questions.filter{$0.question.contains("NBA")}}.count
                self.fun_fact.text = "Ukupno pitanja koja u tekstu pitanja sadrže riječ “NBA”: \(sum_of_questions_containing_NBA)"

                self.tableView.reloadData()
                NSLayoutConstraint.deactivate(self.constraintsWith)
                self.constraintsWith = [NSLayoutConstraint]()
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
                //self.tableView.autoPinEdge(.bottom, to: .top, of: self.logoutButton, withOffset: self.view.frame.height / 50 * -1)
                
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
        button_get.backgroundColor = .orange
        button_get.setTitle("List of Quizzes", for: .normal)
        button_get.setTitleColor(.white, for: .normal)
        button_get.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.addSubview(button_get)
        fun_fact.text = "Fun Fact"
        fun_fact.numberOfLines = 0
        view.addSubview(fun_fact)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .orange
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.addSubview(logoutButton)
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
            
            logoutButton.autoSetDimensions(to: CGSize(width: self.view.frame.width, height: self.view.frame.size.height / 10))
            logoutButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)

            
            didSetupConstraints = true
             
        }
        super.updateViewConstraints()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = categoriesList[section]
        label.textAlignment = .center
        switch categoriesList[section]{
           case "SCIENCE":
               label.backgroundColor = UIColor.green
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
                cell.backgroundColor = UIColor.green
            case "SPORTS":
                cell.backgroundColor = UIColor.blue
            default:
                cell.backgroundColor = UIColor.red
        }

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.button_get.isEnabled = false
        self.tableView.isUserInteractionEnabled = false
        
        let cell = self.tableView.cellForRow(at: indexPath)
        
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
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.isUserInteractionEnabled = true
        self.button_get.isEnabled = true
    }
}

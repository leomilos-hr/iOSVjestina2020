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


class MainViewController: UIViewController {

    var mainView: MainView!
    let defaults = UserDefaults.standard
    var titlesQuiz : [String] = []
    var list_of_quizzes = Quizzes(quizzes:[])
    var categoriesList: [String] = []
    var rowCounter : CGFloat = 0
    var randomQuestion: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
    
    }
    
    func setupView(){
        self.mainView = MainView(frame: self.view.frame)
        self.view.addSubview(mainView)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainView.button_get.addTarget(self, action: #selector(getQuizAction(_:)), for: .touchUpInside)
        mainView.logoutButton.addTarget(self, action: #selector(logOutAction(_:)), for: .touchUpInside)
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
        mainView.button_get.isEnabled = false
        //initilazition of service
        let service = GetQuizService(baseUrl: "https://iosquiz.herokuapp.com/api/")
        service.getAllQuizzes(endPoint: "quizzes")
        service.completionHandler { [weak self] (quizzes, status, message) in
            if status {
                guard let self = self else {return}
                guard let _quizzes = quizzes else {return}
                self.list_of_quizzes = _quizzes
                let sum_of_questions_containing_NBA: Int = self.list_of_quizzes.quizzes.map{$0.questions.filter{$0.question.contains("NBA")}}.count
                self.mainView.fun_fact.text = "Ukupno pitanja koja u tekstu pitanja sadrže riječ “NBA”: \(sum_of_questions_containing_NBA)"

                self.mainView.tableView.reloadData()
                NSLayoutConstraint.deactivate(self.mainView.constraintsWith)
                self.mainView.constraintsWith = [NSLayoutConstraint]()
                let heightTableView1 = self.view.frame.height *  self.rowCounter / 8
                let heightTableView2 = self.view.frame.height *  CGFloat(self.categoriesList.count) / 16
                let heightTableView = heightTableView1 + heightTableView2
                self.rowCounter = 0
                self.mainView.tableView.autoSetDimensions(to: CGSize(width: self.view.frame.width, height: heightTableView))
                self.mainView.c1 = self.mainView.tableView.heightAnchor.constraint(equalToConstant: heightTableView)
                self.mainView.c2 = self.mainView.tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width)
                self.mainView.constraintsWith.append(self.mainView.c1)
                self.mainView.constraintsWith.append(self.mainView.c2)
                NSLayoutConstraint.activate(self.mainView.constraintsWith)
                //self.tableView.autoPinEdge(.bottom, to: .top, of: self.logoutButton, withOffset: self.view.frame.height / 50 * -1)
                
                self.titlesQuiz.removeAll()
            }
            else {
                print(message)
                Alert.showBasic(title: "Greška", message: "Greška u dohvaćanju podataka", vc: self!)
            }
        }
        self.mainView.button_get.isEnabled = true
    }
}



extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = categoriesList[section]
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        switch categoriesList[section]{
           case "SCIENCE":
               label.backgroundColor = .magenta
           case "SPORTS":
               label.backgroundColor = .blue
           default:
               label.backgroundColor = .red
        }
        label.textColor = UIColor.white
        label.layer.borderColor = UIColor.lightGray.cgColor
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
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        //cell.textLabel?.sizeToFit()
        cell.textLabel?.textColor = .white
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.text = quizForCell.description
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.sizeToFit()
        cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.detailTextLabel?.textColor = .white
        cell.detailTextLabel?.textAlignment = .left
        cell.layer.borderColor = UIColor.lightGray.cgColor
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
                cell.backgroundColor = .magenta
            case "SPORTS":
                cell.backgroundColor = .blue
            default:
                cell.backgroundColor = .red
        }

        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mainView.button_get.isEnabled = false
        self.mainView.tableView.isUserInteractionEnabled = false
        
        let cell = self.mainView.tableView.cellForRow(at: indexPath)
        
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
        self.mainView.tableView.deselectRow(at: indexPath, animated: true)
        self.mainView.tableView.isUserInteractionEnabled = true
        self.mainView.button_get.isEnabled = true
    }
}

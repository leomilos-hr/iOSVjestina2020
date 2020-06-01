//
//  LoginViewController.swift
//  QuizApp
//
//  Created by five on 29/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    var loginView: LoginView!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
      
    }
    
    func setupView(){
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.view.addSubview(loginView)
        self.loginView.loginButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
    }
    
    @objc func buttonClicked(_ sender: UIButton!){
        let parameters: [String: Any] = [
            "username" : self.loginView.userField.text!,
            "password" : self.loginView.passwordField.text!
            ]
        
    AF.request("https://iosquiz.herokuapp.com/api/session", method: .post, parameters: parameters, encoding: JSONEncoding.default)
    .responseJSON { response in
        print(response)
        switch response.result {
            case .success(let value):
            let viewController = ViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            if let json = value as? [String: Any] {
                //print(json["user_id"] as! Int)
                //print(json["token"] as! String)
                self.defaults.set(json["user_id"] as! Int, forKey: "user_id")
                self.defaults.set(json["token"] as! String, forKey: "token")
            }
            case .failure(let error):
                print(error)
                Alert.showBasic(title: "Greška", message: "Greška pri logiranju", vc: self)
            }
        }
        
    }

}

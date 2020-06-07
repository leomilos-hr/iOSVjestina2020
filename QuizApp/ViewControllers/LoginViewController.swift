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
        setupView()
      
    }
    
    func setupView(){
        self.loginView = LoginView(frame: self.view.frame)
        self.view.addSubview(loginView)
        self.loginView.loginButton.addTarget(self, action: #selector(self.logInAction), for: .touchUpInside)
        
    }
    
    @objc func logInAction(_ sender: UIButton!){
        let parameters: [String: Any] = [
            "username" : self.loginView.userField.text!,
            "password" : self.loginView.passwordField.text!
            ]
        
        AF.request("https://iosquiz.herokuapp.com/api/session", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate(statusCode: 200..<300)
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success(let value):
                    let viewController = MainViewController()
                    self.navigationController?.pushViewController(viewController, animated: true)
                    if let json = value as? [String: Any] {
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

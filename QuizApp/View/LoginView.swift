//
//  LoginView.swift
//  QuizApp
//
//  Created by five on 29/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import PureLayout
import Alamofire

class LoginView: UIView {
    var shouldSetupConstraints = false
    let defaults = UserDefaults.standard
    
    var userField: UITextField = UITextField()
    var passwordField: UITextField = UITextField()
    var loginButton = makeButton(title: "Login", titleColor: .black, background: .green, borderColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    func setup(){
        backgroundColor = .blue
        userField.backgroundColor = .white
        passwordField.backgroundColor = .white
        self.addSubview(loginButton)
        self.addSubview(userField)
        self.addSubview(passwordField)
        loginButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked(_ sender: UIButton!){
        if ((userField.text?.count)! > 0) {
            defaults.set(userField.text!, forKey: "user")
        }
        if ((passwordField.text?.count)! > 0) {
            defaults.set(passwordField.text!, forKey: "password")
        }
        
        let parameters: [String: Any] = [
            "username" : userField.text!,
            "password" : passwordField.text!
            ]
        
        AF.request("https://iosquiz.herokuapp.com/api/session", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseJSON { response in
            print(response)
        }
    }
    
   override func updateConstraints() {
    if(!shouldSetupConstraints) {
        userField.autoSetDimensions(to: CGSize(width:  self.frame.width / 2, height: self.frame.height / 20))
        userField.autoPinEdge(toSuperviewEdge: .top, withInset: self.frame.width / 2)
        userField.autoAlignAxis(.vertical, toSameAxisOf: self)
        
        passwordField.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 20))
        passwordField.autoPinEdge(.top, to: .bottom, of: userField, withOffset: 30)
        passwordField.autoAlignAxis(.vertical, toSameAxisOf: self)
        
        loginButton.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 15))
        loginButton.autoPinEdge(.top, to: .bottom, of: passwordField, withOffset: 30)
        loginButton.autoAlignAxis(.vertical, toSameAxisOf: self)
        
        shouldSetupConstraints = true
    }
        super.updateConstraints()
    }
    
}

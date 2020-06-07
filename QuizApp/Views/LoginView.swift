//
//  LoginView.swift
//  QuizApp
//
//  Created by five on 29/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import PureLayout

class LoginView: UIView {
    var shouldSetupConstraints = false
    var userLabel: UILabel = UILabel()
    var passwordLabel: UILabel = UILabel ()
    var userField: UITextField = UITextField()
    var passwordField: UITextField = UITextField()
    var loginButton : UIButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    func setup(){
        backgroundColor = .darkText
        userField.backgroundColor = .white
        passwordField.backgroundColor = .white
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .orange
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(loginButton)
        self.addSubview(userField)
        self.addSubview(passwordField)
        userLabel.text = "Username"
        userLabel.textAlignment = .left
        userLabel.textColor = .white
        userLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.addSubview(userLabel)
        passwordLabel.text = "Password"
        passwordLabel.textAlignment = .left
        passwordLabel.textColor = .white
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.addSubview(passwordLabel)
        assignbackground()
    }
    
    func assignbackground(){
        let background = UIImage(named: "background2.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = self.center
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
    }
    
    override func updateConstraints() {
        if(!shouldSetupConstraints) {
            userLabel.autoSetDimensions(to: CGSize(width:  self.frame.width / 2, height: self.frame.height / 20))
            userLabel.autoPinEdge(toSuperviewEdge: .top, withInset: self.frame.width / 15)
            userLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            userField.autoSetDimensions(to: CGSize(width:  self.frame.width / 2, height: self.frame.height / 20))
            userField.autoPinEdge(.top, to: .bottom, of: userLabel, withOffset: self.frame.width / 50)
            userField.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            passwordLabel.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 20))
            passwordLabel.autoPinEdge(.top, to: .bottom, of: userField, withOffset: self.frame.width / 50)
            passwordLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            passwordField.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 20))
            passwordField.autoPinEdge(.top, to: .bottom, of: passwordLabel, withOffset: self.frame.width / 50)
            passwordField.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            loginButton.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 15))
            loginButton.autoPinEdge(.top, to: .bottom, of: passwordField, withOffset: self.frame.width / 10)
            loginButton.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            shouldSetupConstraints = true
        }
        super.updateConstraints()
    }
}

//
//  MainView.swift
//  QuizApp
//
//  Created by five on 07/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import PureLayout

class MainView: UIView {
    var shouldSetupConstraints = false
    var fun_fact = UILabel()
    var button_get = UIButton()
    var tableView = UITableView()
    var constraintsWith = [NSLayoutConstraint]()
    var c1 : NSLayoutConstraint!
    var c2 : NSLayoutConstraint!
    var logoutButton : UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        setup()
        updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    func setup(){
        backgroundColor = .white
        button_get.backgroundColor = .orange
        button_get.setTitle("List of Quizzes", for: .normal)
        button_get.setTitleColor(.white, for: .normal)
        button_get.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(button_get)
        fun_fact.text = "Fun Fact"
        fun_fact.numberOfLines = 0
        fun_fact.font = UIFont.boldSystemFont(ofSize: 20.0)
        fun_fact.textColor = .white
        self.addSubview(fun_fact)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .orange
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(logoutButton)
        assignbackground()
    }
    
    func assignbackground(){
           let background = UIImage(named: "background.jpg")
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
            
            button_get.autoSetDimensions(to: CGSize(width: self.frame.width / 2, height: self.frame.size.height / 10))
            button_get.autoPinEdge(toSuperviewEdge: .top, withInset: self.frame.height / 20)
            button_get.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            fun_fact.autoPinEdge(.top, to: .bottom, of: button_get, withOffset: self.frame.height / 30)
            fun_fact.autoPinEdge(toSuperviewEdge: .trailing, withInset: self.frame.width / 30)
            fun_fact.autoPinEdge(toSuperviewEdge: .leading, withInset: self.frame.width / 30)
            
            logoutButton.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 10))
            logoutButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: self.frame.height / 10)
            
            tableView.autoPinEdge(.top, to: .bottom, of: fun_fact, withOffset: self.frame.height / 30)
            c1 = tableView.heightAnchor.constraint(equalToConstant: 0)
            c2 = tableView.widthAnchor.constraint(equalToConstant: frame.width)
            constraintsWith.append(c1)
            constraintsWith.append(c2)
            NSLayoutConstraint.activate(constraintsWith)
            
            shouldSetupConstraints = true
        }
        super.updateConstraints()
    }
}

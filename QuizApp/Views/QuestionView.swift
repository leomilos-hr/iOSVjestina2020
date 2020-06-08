//
//  QuestionView.swift
//  QuizApp
//
//  Created by five on 29/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import PureLayout

class QuestionView: UIView {
    
    var shouldSetupConstraints = true
    
    var qlabel: UILabel = UILabel()
    var button_a = CustomButton()
    var button_b =  CustomButton()
    var button_c =  CustomButton()
    var button_d =  CustomButton()
    var button_exit =  CustomButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        backgroundColor = .darkGray
        qlabel.backgroundColor = .darkGray
        qlabel.numberOfLines = 0
        qlabel.textAlignment = .center
        qlabel.textColor = .white
        qlabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        qlabel.adjustsFontSizeToFitWidth = true
        qlabel.layer.cornerRadius = 20.0
        qlabel.layer.masksToBounds = true
        self.addSubview(qlabel)
        button_a.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button_b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button_c.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button_d.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button_exit.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button_a.layer.cornerRadius = 20.0
        button_a.layer.masksToBounds = true
        button_b.layer.cornerRadius = 20.0
        button_b.layer.masksToBounds = true
        button_c.layer.cornerRadius = 20.0
        button_c.layer.masksToBounds = true
        button_d.layer.cornerRadius = 20.0
        button_d.layer.masksToBounds = true
        self.addSubview(button_a)
        self.addSubview(button_b)
        self.addSubview(button_c)
        self.addSubview(button_d)
        button_exit.backgroundColor = .orange
        self.addSubview(button_exit)
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
        if(shouldSetupConstraints) {
            qlabel.autoSetDimensions(to: CGSize(width: self.frame.width * 5/6, height: self.frame.height / 8))
            qlabel.autoPinEdge(toSuperviewEdge: .top, withInset: self.frame.height / 100)
            qlabel.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            button_a.autoSetDimensions(to: CGSize(width: self.frame.width * 4/5, height: self.frame.height / 8))
            button_a.autoPinEdge(.top, to: .bottom, of: qlabel, withOffset: self.frame.height / 100)
            button_a.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            button_b.autoSetDimensions(to: CGSize(width: self.frame.width * 4/5, height: self.frame.height / 8))
            button_b.autoPinEdge(.top, to: .bottom, of: button_a, withOffset: self.frame.height / 100)
            button_b.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            button_c.autoSetDimensions(to: CGSize(width: self.frame.width * 4/5, height: self.frame.height / 8))
            button_c.autoPinEdge(.top, to: .bottom, of: button_b, withOffset: self.frame.height / 100)
            button_c.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            button_d.autoSetDimensions(to: CGSize(width: self.frame.width * 4/5, height: self.frame.height / 8))
            button_d.autoPinEdge(.top, to: .bottom, of: button_c, withOffset: self.frame.height / 100)
            button_d.autoAlignAxis(.vertical, toSameAxisOf: self)
            
            button_exit.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 10))
            button_exit.autoPinEdge(toSuperviewEdge: .bottom, withInset: self.frame.height / 10)
            

            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}


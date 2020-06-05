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
        qlabel.backgroundColor = .clear
        qlabel.numberOfLines = 0
        qlabel.textAlignment = .center
        qlabel.textColor = .white
        qlabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        qlabel.adjustsFontSizeToFitWidth = true
        self.addSubview(qlabel)
        self.addSubview(button_a)
        self.addSubview(button_b)
        self.addSubview(button_c)
        self.addSubview(button_d)
        button_exit.backgroundColor = .orange
        self.addSubview(button_exit)
        backgroundSetup()
    }
    
    func backgroundSetup(){
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
        if(shouldSetupConstraints) {
            qlabel.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height / 8))
            qlabel.autoPinEdge(toSuperviewEdge: .top, withInset: self.frame.height / 100)
            
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
            
            button_exit.autoSetDimensions(to: CGSize(width: self.frame.width * 4/5, height: self.frame.height / 8))
            button_exit.autoPinEdge(.top, to: .bottom, of: button_d, withOffset: self.frame.height / 100)
            button_exit.autoAlignAxis(.vertical, toSameAxisOf: self)

            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}


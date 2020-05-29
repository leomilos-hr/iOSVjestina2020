//
//  ButtonMake.swift
//  QuizApp
//
//  Created by five on 29/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit


func makeButton(title: String? = nil,
                              titleColor: UIColor = .black,
                              font: UIFont? = nil,
                              background: UIColor = .clear,
                              cornerRadius: CGFloat = 0,
                              borderWidth: CGFloat = 0,
                              borderColor: UIColor = .clear) -> UIButton {
           let button = UIButton()
           button.setTitle(title, for: .normal)
           button.setTitleColor(titleColor, for: .normal)
           button.backgroundColor = background
           button.titleLabel?.font = font
           button.titleLabel?.adjustsFontSizeToFitWidth = true
           return button
       }

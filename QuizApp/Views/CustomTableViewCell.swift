//
//  CustomTableViewCell.swift
//  QuizApp
//
//  Created by five on 29/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class CustomTableViewCell: UITableViewCell {
    
    //var shouldSetupConstraints = false
    var textLevel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Here you can customize the appearance of your cell
    override func layoutSubviews() {
        super.layoutSubviews()
    
        self.imageView?.autoSetDimensions(to: CGSize(width: self.frame.width / 5, height: self.frame.height * 4/5))
        self.imageView?.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        self.imageView?.autoPinEdge(.top, to: .top, of: self, withOffset: 10)
               
        self.textLabel?.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height * 2/5))
        self.textLabel?.autoPinEdge(.left, to: .right, of: self.imageView!, withOffset: 15)
        self.textLabel?.autoPinEdge(.right, to: .right, of: self, withOffset: -100)
        
        self.detailTextLabel?.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height * 3/5))
        self.detailTextLabel?.autoPinEdge(.left, to: .right, of: self.imageView!, withOffset: 15)
        self.detailTextLabel?.autoPinEdge(.top, to: .bottom, of: self.textLabel!, withOffset: 0)
        self.detailTextLabel?.autoPinEdge(.right, to: .right, of: self, withOffset: -100)
        
        self.textLevel.autoSetDimensions(to: CGSize(width: self.frame.width, height: self.frame.height * 2/5))
        self.textLevel.autoPinEdge(.top, to: .top, of: self, withOffset: 0)
        self.textLevel.autoPinEdge(.left, to: .right, of: self.textLabel!, withOffset: 50)
        self.textLevel.autoPinEdge(.right, to: .right, of: self, withOffset: -5)
    }
}

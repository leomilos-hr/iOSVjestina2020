//
//  CustomTableViewCell.swift
//  QuizApp
//
//  Created by five on 29/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit
import PureLayout

class CustomTableViewCell: UITableViewCell {
    
    var textLevel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    
        self.imageView?.autoSetDimensions(to: CGSize(width: self.frame.width * 3/15, height: self.frame.height * 4/5))
        self.imageView?.autoPinEdge(toSuperviewEdge: .left, withInset: self.frame.width / 30)
        self.imageView?.autoPinEdge(.top, to: .top, of: self, withOffset: 10)
               
        self.textLabel?.autoSetDimensions(to: CGSize(width: self.frame.width * 7/15, height: self.frame.height * 2/5))
        self.textLabel?.autoPinEdge(.left, to: .right, of: self.imageView!, withOffset: self.frame.width / 30)
    
        
        self.detailTextLabel?.autoSetDimensions(to: CGSize(width: self.frame.width * 7/15, height: self.frame.height * 3/5))
        self.detailTextLabel?.autoPinEdge(.left, to: .right, of: self.imageView!, withOffset: self.frame.width / 30)
        self.detailTextLabel?.autoPinEdge(.top, to: .bottom, of: self.textLabel!, withOffset: 0)
        
        self.textLevel.autoSetDimensions(to: CGSize(width: self.frame.width * 3/15, height: self.frame.height * 2/5))
        self.textLevel.autoPinEdge(.top, to: .top, of: self, withOffset: 0)
        self.textLevel.autoPinEdge(.left, to: .right, of: self.textLabel!, withOffset: self.frame.width / 20)
    }
}

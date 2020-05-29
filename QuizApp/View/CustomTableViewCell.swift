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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Here you can customize the appearance of your cell
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 0,y: 0,width: self.frame.width / 5, height: self.frame.height)
        self.textLabel?.frame = CGRect(x: self.frame.width / 5 + 10,y: 0,width: self.frame.width, height: self.frame.height)
    }
}

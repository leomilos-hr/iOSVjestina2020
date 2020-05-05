//
//  CustomTableViewCell.swift
//  QuizApp
//
//  Created by five on 05/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

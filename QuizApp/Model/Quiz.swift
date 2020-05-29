//
//  Quiz.swift
//  QuizApp
//
//  Created by five on 20/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation

struct Quiz: Decodable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let level: Int
    let image: String
    let questions:[Question]
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case description = "description"
            case category = "category"
            case level = "level"
            case image = "image"
            case questions = "questions"
    }
}

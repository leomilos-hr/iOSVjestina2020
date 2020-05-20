//
//  Question.swift
//  QuizApp
//
//  Created by five on 20/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation

struct Question: Decodable {
    let id: Int
    let question: String
    let answers: [String]
    let correct_answer: Int
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case question = "question"
            case answers = "answers"
            case correct_answer = "correct_answer"

    }
}

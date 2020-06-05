//
//  Service.swift
//  QuizApp
//
//  Created by five on 20/05/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import Alamofire

class GetQuizService {
    fileprivate var baseUrl = ""
    typealias quizzesCallBack = (_ quizzes:Quizzes?, _ status: Bool, _ message:String) -> Void
    
    var callBack: quizzesCallBack?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getAllQuizzes(endPoint:String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "error u dohvaćanju")

                return}
            do {
            let quizzes = try JSONDecoder().decode(Quizzes.self, from: data)
                self.callBack?(quizzes, true,"")
            } catch {
                self.callBack?(nil, false, "error u parsiranju")
            }
        }
    }
    
    func completionHandler(callBack: @escaping quizzesCallBack) {
        self.callBack = callBack
    }
}

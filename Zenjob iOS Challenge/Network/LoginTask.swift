//
//  LoginTask.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

class LoginTask: Operation {
  var username: String
  var password: String

  var request: Request {
    return UserRequests.login(username: self.username, password: self.password)
  }

  init(username: String, password: String) {
    self.username = username
    self.password = password
  }

  func execute(in dispatcher: Dispatcher, completion: @escaping (User?, Error?) -> Void) {
    do {
      try dispatcher.execute(request: self.request) { (response) in
        switch response {
        case .json(let data):
          let decoder = JSONDecoder()
          do {
            let user = try decoder.decode(User.self, from: data)
            completion(user, nil)
          } catch {
            print("Failed to decode JSON")
            completion(nil, error)
          }
        case .data(_):
          break
        case .error(_, let error):
          completion(nil, error)
        }
      }
    } catch {
      completion(nil, error)
    }
  }
}

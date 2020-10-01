//
//  UserRequests.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

public enum UserRequests: Request {

  case login(username: String, password: String)

  public var path: String {
    switch self {
    case .login(_,_):
      return "/auth"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .login(_,_):
      return .post
    }
  }

  public var parameters: RequestParams {
    switch self {
    case .login(let username, let password):
      return .body(["username": username, "password": password])
    }
  }

  public var headers: [String : Any]? {
    switch self {
    default:
      return ["Content-Type": "application/json"]
    }
  }

  public var dataType: DataType {
    switch self {
    case .login(_,_):
      return .JSON
    }
  }
}

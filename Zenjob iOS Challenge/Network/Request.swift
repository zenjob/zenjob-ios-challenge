//
//  Request.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

public protocol Request {

  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: RequestParams { get }
  var headers: [String: Any]? { get }
  var dataType: DataType { get }
}


public enum HTTPMethod: String {
  case post = "POST"
  case put = "PUT"
  case get = "GET"
  case delete = "DELETE"
}


public enum RequestParams {
  case body(_ : [String: Any]?)
  case url(_ : [String: Any]?)
}


public enum DataType {
  case JSON
  case Data
}

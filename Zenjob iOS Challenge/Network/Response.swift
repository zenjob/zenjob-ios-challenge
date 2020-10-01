//
//  Response.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

public enum Response {
  case json(_: Data)
  case data(_: Data)
  case error(_: Int?, _: Error?)

  /**
   Initialize a new Response.
   - Parameters:
      - response: response returned from HTTP request with a response, data, and error parameters
      - request: the request that returned the response
   */
  init(_ response: (response: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
    guard response.response?.statusCode == 200, response.error == nil else {
      self = .error(response.response?.statusCode, response.error)
      return
    }

    guard let data = response.data else {
      self = .error(response.response?.statusCode, NetworkErrors.noData)
      return
    }

    switch request.dataType {
    case .Data:
      self = .data(data)
    case .JSON:
      self = .json(data)
    }
  }
}

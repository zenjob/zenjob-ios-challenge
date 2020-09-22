//
//  Environment.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

public struct Environment {

  public var name: String
  public var host: String
  public var headers: [String: Any] = [:]
  public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData

  public init(_ name: String, host: String) {
    self.name = name
    self.host = host
  }

}

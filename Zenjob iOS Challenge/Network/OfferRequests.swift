//
//  OfferRequests.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

public enum OfferRequests: Request {

  case offers(offset: String, token: String)
  case offer(id: String, token: String)

  public var path: String {
    switch self {
    case .offers(_, _):
      return "/offers?offset="
    case .offer(let id, _):
      return "/offers/\(id)"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .offers(_, _):
      return .get
    case .offer(_, _):
      return .get
    }
  }

  public var parameters: RequestParams {
    switch self {
    case .offers(let offset, _):
      return .url(["offset": offset])
    case .offer(_, _):
      return .url([:])
    }
  }

  public var headers: [String : Any]? {
    switch self {
    case .offers(_, let token):
      return ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
    case .offer(_, let token):
      return ["Content-Type": "application/json", "Authorization": "Bearer \(token)"]
    }
  }

  public var dataType: DataType {
    switch self {
    case .offers(_, _):
      return .JSON
    case .offer(_, _):
      return .JSON
    }
  }
}

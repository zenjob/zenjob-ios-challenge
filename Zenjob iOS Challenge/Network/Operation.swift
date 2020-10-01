//
//  Operation.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

protocol Operation {

  associatedtype Output

  var request: Request { get }
  func execute(in dispatcher: Dispatcher, completion: @escaping (_ onSuccess: Output?, _ onError: Error?) -> Void)

}

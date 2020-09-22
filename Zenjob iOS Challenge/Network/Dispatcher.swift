//
//  Dispatcher.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

public protocol Dispatcher {
    
  init(environment: Environment)

  func execute(request: Request, completion: @escaping (_ response: Response) -> Void) throws

}

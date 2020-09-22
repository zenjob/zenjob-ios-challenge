//
//  GetOffersTask.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

class GetOffersTask: Operation {
    
    var offset: String
    var token: String
    
    var request: Request {
        return OfferRequests.offers(offset: offset, token: token)
    }
    
    init(offset: String, token: String) {
        self.offset = offset
        self.token = token
    }
    
    
    func execute(in dispatcher: Dispatcher, completion: @escaping ([Offer]?, Error?) -> Void) {
        do {
            try dispatcher.execute(request: self.request) { (response) in
                switch response {
                case .json(let data):
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        
                        if let total = jsonObject?["total"] as? Int {
                            UserDefaults.standard.set(total, forKey: "totalJobs")
                        }
                        
                        if let jsonOffers = jsonObject?["offers"] {
                            let data = try JSONSerialization.data(withJSONObject: jsonOffers, options: .init(rawValue: 0))
                            let offers = try decoder.decode([Offer].self, from: data)
                            completion(offers, nil)
                        }
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

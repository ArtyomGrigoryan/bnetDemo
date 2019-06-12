//
//  NetworkService.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Alamofire
import Foundation

protocol Networking {
    func request(params: [String: String], header: [String: String], completion: @escaping ([String : Any]?, String?) -> Void)
}

class NetworkService: Networking {
    func request(params: [String : String], header: [String : String], completion: @escaping ([String : Any]?, String?) -> Void) {
        guard let url = URL(string: API.host) else { return }
        let queue = DispatchQueue(label: "bnet", qos: .background, attributes: .concurrent)
   
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding(destination: .httpBody), headers: header).responseJSON(queue: queue) { (response) in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                completion(json, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}

//
//  NetworkDataFetcher.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func addNewRecord(session: String, userText: String, completion: @escaping (ServerResponse?, String?) -> Void)
    func getSession(completion: @escaping (ServerResponse?, String?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    let networking: Networking
    let header = ["token": AuthService.shared.getToken()]
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func addNewRecord(session: String, userText: String, completion: @escaping (ServerResponse?, String?) -> Void) {
        let parameters = ["a": API.addEntry,
                          "session": session,
                          "body": userText]
        
        networking.request(params: parameters, header: header) { (json, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let data = try? JSONSerialization.data(withJSONObject: json as Any)
                let decoded = self.decodeJSON(type: ServerResponse.self, from: data)
                completion(decoded, nil)
            }
        }
    }
    
    func getSession(completion: @escaping (ServerResponse?, String?) -> Void) {
        let parameters = ["a": API.newsSession]

        networking.request(params: parameters, header: header) { (json, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let data = try? JSONSerialization.data(withJSONObject: json as Any)
                let decoded = self.decodeJSON(type: ServerResponse.self, from: data)
                completion(decoded, nil)
            }
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}

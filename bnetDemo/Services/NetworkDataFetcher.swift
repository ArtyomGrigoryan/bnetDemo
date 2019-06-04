//
//  NetworkDataFetcher.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getSession(completion: @escaping (SessionResponse?, String?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    let networking: Networking
    let header = ["token": AuthService.shared.getToken()]
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getSession(completion: @escaping (SessionResponse?, String?) -> Void) {
        let parameters = ["a": API.newsSession]

        networking.request(params: parameters, header: header) { (data, error) in
            if let error = error {
                completion(nil, error)
            } else {
                let decoded = self.decodeJSON(type: SessionResponse.self, from: data)
                //если был передан неверный токен, то
                if decoded == nil {
                    completion(nil, "Invalid token")
                } else {
                    completion(decoded, nil)
                }
            }
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}

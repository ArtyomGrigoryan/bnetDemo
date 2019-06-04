//
//  AuthService.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

class AuthService {
    private let token: String
    static let shared = AuthService()
    
    func getToken() -> String {
        return token
    }
    
    private init() {
        self.token = "PRWPe8Q-Pz-LtnwOKV"
    }
}

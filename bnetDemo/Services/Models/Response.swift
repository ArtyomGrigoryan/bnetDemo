//
//  Models.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

struct SessionResponse: Decodable {
    let data: Session?
    let status: Int
    let error: String?
    
}

struct Session: Decodable {
    let session: String
}

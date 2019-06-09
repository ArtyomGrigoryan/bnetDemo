//
//  Models.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright © 2019 Artyom Grigoryan. All rights reserved.
//

import Foundation

struct ServerResponse: Decodable {
    let data: ResponseData?
    let error: String?
    let status: Int
}

struct ResponseData: Decodable {
    let session: String?
    let id: String?
}

//структуры, необходимые для вывода записей пользователя
struct ServerResponse2: Decodable {
    let data: [[ResponseData2]]
    let error: String?
    let status: Int
}

struct ResponseData2: Decodable {
    let id: String
    let body: String
    let da: String
    let dm: String
}

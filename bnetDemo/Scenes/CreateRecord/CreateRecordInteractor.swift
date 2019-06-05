//
//  CreateRecordInteractor.swift
//  bnetDemo
//
//  Created by Артем Григорян on 05/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol CreateRecordBusinessLogic {
    func makeRequest(request: CreateRecord.Model.Request.RequestType)
}

protocol CreateRecordDataStore {
    var session: String { get set }
}

class CreateRecordInteractor: CreateRecordBusinessLogic, CreateRecordDataStore {

    var presenter: CreateRecordPresentationLogic?
    var service: CreateRecordService?
    var session: String = "" 
  
    func makeRequest(request: CreateRecord.Model.Request.RequestType) {
        if service == nil {
            service = CreateRecordService()
        }
    }
}

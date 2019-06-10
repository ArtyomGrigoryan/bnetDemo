//
//  ShowRecordInteractor.swift
//  bnetDemo
//
//  Created by Артем Григорян on 09/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowRecordBusinessLogic {
    func makeRequest(request: ShowRecord.Model.Request.RequestType)
}

protocol ShowRecordDataStore {
    var records: ResponseData2? { get set }
}

class ShowRecordInteractor: ShowRecordBusinessLogic, ShowRecordDataStore {

    var records: ResponseData2?
    var presenter: ShowRecordPresentationLogic?
  
    func makeRequest(request: ShowRecord.Model.Request.RequestType) {
        switch request {
        case .getRecord:
            self.presenter?.presentData(response: .presentResponseData(records: self.records!))
        }
    }
}

//
//  RecordsListInteractor.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListBusinessLogic {
    func makeRequest(request: RecordsList.Model.Request.RequestType)
}

protocol RecordsListDataStore {
    var session: String { get set }
}

class RecordsListInteractor: RecordsListBusinessLogic, RecordsListDataStore {

    var presenter: RecordsListPresentationLogic?
    var session: String = ""
  
    func makeRequest(request: RecordsList.Model.Request.RequestType) {
        switch request {
        case .getSession:
            presenter?.presentData(response: RecordsList.Model.Response.ResponseType.presentSession(session: session))
        }
    }
}

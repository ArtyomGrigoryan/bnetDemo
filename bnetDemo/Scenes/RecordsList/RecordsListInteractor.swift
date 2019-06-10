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
    var records: [ResponseData2]? { get set }
}

class RecordsListInteractor: RecordsListBusinessLogic, RecordsListDataStore {

    var session = ""
    var records: [ResponseData2]?
    var presenter: RecordsListPresentationLogic?
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
  
    func makeRequest(request: RecordsList.Model.Request.RequestType) {
        switch request {
        case .getRecords:
            fetcher.getRecords(session: session) { [weak self] (response, error) in
                guard let self = self, let response = response else { return }
                
                _ = response.data.compactMap {
                    self.records = $0
                }
                
                self.presenter?.presentData(response: .presentResponseData(records: self.records!))
            }
        }
    }
}

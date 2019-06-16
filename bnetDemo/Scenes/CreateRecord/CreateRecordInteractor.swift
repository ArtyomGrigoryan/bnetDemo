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
    var session: String! { get set }
}

class CreateRecordInteractor: CreateRecordBusinessLogic, CreateRecordDataStore {

    var session: String!
    var presenter: CreateRecordPresentationLogic?
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
    private let emptyTextAreaErrorMessage = "Пожалуйста, напишите что-нибудь в текстовое поле."
  
    func makeRequest(request: CreateRecord.Model.Request.RequestType) {
        switch request {
        case .passUserText(let userText):
            if userText.trimmingCharacters(in: .whitespaces).isEmpty {
                self.presenter?.presentData(response: .failure(error: emptyTextAreaErrorMessage))
            } else {
                let userText = userText.trimmingCharacters(in: .whitespaces).capitalized
                
                fetcher.addNewRecord(session: session, userText: userText) { [weak self] (response, error) in
                    if let _ = response?.data {
                        self?.presenter?.presentData(response: .success)
                    } else {
                        self?.presenter?.presentData(response: .failure(error: error!.localizedDescription))
                    }
                }
            }
        }
    }
}

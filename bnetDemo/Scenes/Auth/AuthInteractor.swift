//
//  AuthInteractor.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol AuthBusinessLogic {
    func makeRequest(request: Auth.Model.Request.RequestType)
}

protocol AuthDataStore {
    var session: String { get set }
}

class AuthInteractor: AuthBusinessLogic, AuthDataStore {

    var session: String = ""
    var presenter: AuthPresentationLogic?
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  
    func makeRequest(request: Auth.Model.Request.RequestType) {
        switch request {
        case .getSession:
            fetcher.getSession { [weak self] (response, error) in
                if let response = response {
                    self?.session = response.data.session
                    self?.presenter?.presentData(response: Auth.Model.Response.ResponseType.presentSession(response: response, error: nil))
                } else {
                    print("В интеракторе взглянем error \(error)")
                    self?.presenter?.presentData(response: Auth.Model.Response.ResponseType.presentSession(response: nil, error: error))
                }
            }
        }
    }
}

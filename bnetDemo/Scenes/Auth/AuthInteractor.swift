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
    var session: String! { get }
}

class AuthInteractor: AuthBusinessLogic, AuthDataStore {

    var session: String!
    var presenter: AuthPresentationLogic?
    private var fetcher = NetworkDataFetcher(networking: NetworkService())
  
    func makeRequest(request: Auth.Model.Request.RequestType) {
        switch request {
        case .getSession:
            fetcher.getSession { [weak self] (response, error) in
                if let data = response?.data {
                    print(1)
                    self?.session = data.session!
                    self?.presenter?.presentData(response: .success)
                } else if let err = response?.error {
                    print(2)
                    self?.presenter?.presentData(response: .failure(error: err))
                } else {
                    print(3)
                    self?.presenter?.presentData(response: .failure(error: error!.localizedDescription))
                }
            }
        }
    }
}

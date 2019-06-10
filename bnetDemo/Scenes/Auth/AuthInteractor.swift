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

    var session = ""
    var presenter: AuthPresentationLogic?
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  
    func makeRequest(request: Auth.Model.Request.RequestType) {
        switch request {
        case .getSession:
            fetcher.getSession { [weak self] (response, error) in
                if let response = response {
                    if let data = response.data {
                        self?.session = data.session!
                        self?.presenter?.presentData(response: Auth.Model.Response.ResponseType.success)
                    } else if let error = response.error {
                        self?.presenter?.presentData(response: Auth.Model.Response.ResponseType.error(error: error))
                    }
                //блок else для вывода сообщения об отсутствии интернет-соединения на кириллице
                } else {
                    self?.presenter?.presentData(response: .error(error: error!))
                }
            }
        }
    }
}

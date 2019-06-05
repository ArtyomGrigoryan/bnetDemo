//
//  AuthPresenter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol AuthPresentationLogic {
    func presentData(response: Auth.Model.Response.ResponseType)
}

class AuthPresenter: AuthPresentationLogic {
    weak var viewController: AuthDisplayLogic?
    var viewModel: SessionViewModel?
  
    func presentData(response: Auth.Model.Response.ResponseType) {
        switch response {
        case .presentSession(let response, let error):
            if let response = response {
                if let error = response.error {
                    viewModel = SessionViewModel(session: response.data?.session, errorTitle: "Ошибка", errorMessage: error)
                } else {
                    viewModel = SessionViewModel(session: response.data?.session, errorTitle: nil, errorMessage: nil)
                }
            //данный код будет вызван только в том случае, если отсутствует интернет-соединение
            } else {
                viewModel = SessionViewModel(session: nil, errorTitle: error, errorMessage: "Повторите попытку.")
            }
            viewController?.displayData(viewModel: .displaySession(sessionViewModel: viewModel!))
        }
    }
}

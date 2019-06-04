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
  
    func presentData(response: Auth.Model.Response.ResponseType) {
        switch response {
        case .presentSession(let response, let error):
            if let response = response {
                let viewModel = SessionViewModel(session: response.data.session, errorTitle: nil, errorMessage: nil)
                viewController?.displayData(viewModel: .displaySession(sessionViewModel: viewModel))
            } else {
                let viewModel = SessionViewModel(session: nil, errorTitle: "Ошибка", errorMessage: error)
                viewController?.displayData(viewModel: .displaySession(sessionViewModel: viewModel))
            }
//            let viewModel = SessionViewModel(session: response!.data.session, errorTitle: nil, errorMessage: nil)
//            viewController?.displayData(viewModel: .displaySession(sessionViewModel: viewModel))
        }
    }
}

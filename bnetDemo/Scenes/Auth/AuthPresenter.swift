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
        case .success:
            viewController?.displayData(viewModel: .success)
        case .failure(let error):
            viewController?.displayData(viewModel: .presentFailure(errorTitle: error))
        }
    }
}

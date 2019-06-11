//
//  CreateRecordPresenter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 05/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol CreateRecordPresentationLogic {
    func presentData(response: CreateRecord.Model.Response.ResponseType)
}

class CreateRecordPresenter: CreateRecordPresentationLogic {
    weak var viewController: CreateRecordDisplayLogic?
  
    func presentData(response: CreateRecord.Model.Response.ResponseType) {
        switch response {
        case .success:
             viewController?.displayData(viewModel: .success)
        case .failure(let error):
            viewController?.displayData(viewModel: .presentFailure(error: error))
        }
    }
}

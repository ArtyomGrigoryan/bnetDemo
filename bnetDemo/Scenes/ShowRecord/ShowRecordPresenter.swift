//
//  ShowRecordPresenter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 09/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowRecordPresentationLogic {
    func presentData(response: ShowRecord.Model.Response.ResponseType)
}

class ShowRecordPresenter: ShowRecordPresentationLogic {
    
    weak var viewController: ShowRecordDisplayLogic?
  
    func presentData(response: ShowRecord.Model.Response.ResponseType) {
        switch response {
        case .presentResponseData(let record):
            viewController?.displayData(viewModel: .displayRecord(recordBody: record.body))
        }
    }
}

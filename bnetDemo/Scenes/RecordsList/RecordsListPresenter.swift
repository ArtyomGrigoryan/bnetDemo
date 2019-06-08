//
//  RecordsListPresenter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListPresentationLogic {
    func presentData(response: RecordsList.Model.Response.ResponseType)
}

class RecordsListPresenter: RecordsListPresentationLogic {
    weak var viewController: RecordsListDisplayLogic?
  
    func presentData(response: RecordsList.Model.Response.ResponseType) {

    }
}

//
//  CreateRecordRouter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 05/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol CreateRecordRoutingLogic {

}

protocol CreateRecordDataPassing {
    var dataStore: CreateRecordDataStore? { get }
}

class CreateRecordRouter: NSObject, CreateRecordRoutingLogic, CreateRecordDataPassing {

    weak var viewController: CreateRecordViewController?
    var dataStore: CreateRecordDataStore?
    
    // MARK: - Routing
  
}

//
//  ShowRecordRouter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 09/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowRecordRoutingLogic {

}

protocol ShowRecordDataPassing {
    var dataStore: ShowRecordDataStore? { get }
}

class ShowRecordRouter: NSObject, ShowRecordRoutingLogic, ShowRecordDataPassing {
    
    var dataStore: ShowRecordDataStore?
    weak var viewController: ShowRecordViewController?
  
    // MARK: - Routing
  
}

//
//  RecordsListRouter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListRoutingLogic {

}

protocol RecordsListDataPassing {
    var dataStore: RecordsListDataStore? { get }
    
}

class RecordsListRouter: NSObject, RecordsListRoutingLogic, RecordsListDataPassing {
    
    var dataStore: RecordsListDataStore?
    weak var viewController: RecordsListViewController?
  
    // MARK: Routing
  
}

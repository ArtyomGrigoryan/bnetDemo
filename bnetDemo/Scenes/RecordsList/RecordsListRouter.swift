//
//  RecordsListRouter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

@objc protocol RecordsListRoutingLogic {
    func routeToCreateRecord(segue: UIStoryboardSegue)
}

protocol RecordsListDataPassing {
    var dataStore: RecordsListDataStore? { get }
}

class RecordsListRouter: NSObject, RecordsListRoutingLogic, RecordsListDataPassing {

    var dataStore: RecordsListDataStore?
    weak var viewController: RecordsListViewController?
  
    // MARK: - Routing
  
    func routeToCreateRecord(segue: UIStoryboardSegue) {
        let nvc = segue.destination as! UINavigationController
        let dvc = nvc.topViewController as! CreateRecordViewController
        var destinationDS = dvc.router!.dataStore!
        passDataToCreateRecord(source: dataStore!, destination: &destinationDS)
    }
    
    //из какого источника данных в какой
    func passDataToCreateRecord(source: RecordsListDataStore, destination: inout CreateRecordDataStore) {
        destination.session = source.session
    }
}

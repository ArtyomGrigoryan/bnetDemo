//
//  AuthRouter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol AuthRoutingLogic {
    func routeToRecordsList(segue: UIStoryboardSegue?)
}

protocol AuthDataPassing {
    var dataStore: AuthDataStore? { get }
}

class AuthRouter: NSObject, AuthRoutingLogic, AuthDataPassing {
  
    var dataStore: AuthDataStore?
    weak var viewController: AuthViewController?
  
    // MARK: Routing
  
    func routeToRecordsList(segue: UIStoryboardSegue?) {
        let storyboard = UIStoryboard(name: "Records", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecordsListViewController") as! RecordsListViewController
        let destinationNavigationVC = UINavigationController(rootViewController: vc)
        var destinationDS = vc.router!.dataStore!   
        self.passDataToDetail(source: self.dataStore!, destination: &destinationDS)
        self.navigateToDetail(source: self.viewController!, destination: destinationNavigationVC)
    }
    
    //из какого вью контроллера в какой
    func navigateToDetail(source: AuthViewController, destination: UINavigationController) {
        source.show(destination, sender: nil)
    }
    
    //из какого источника данных в какой
    func passDataToDetail(source: AuthDataStore, destination: inout RecordsListDataStore) {
        destination.session = source.session
    }
}

//
//  AuthViewController.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol AuthDisplayLogic: class {
    func displayData(viewModel: Auth.Model.ViewModel.ViewModelData)
}

class AuthViewController: UIViewController, AuthDisplayLogic {

    var interactor: AuthBusinessLogic?
    var router: (NSObjectProtocol & AuthRoutingLogic & AuthDataPassing)?

    // MARK: Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = AuthInteractor()
        let presenter             = AuthPresenter()
        let router                = AuthRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }

    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getSessionButtonPressed(_ sender: UIButton) {
        interactor?.makeRequest(request: .getSession)
    }
  
    func displayData(viewModel: Auth.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .success:
            router?.routeToRecordsList(segue: nil)
        case .error(let errorTitle):
            errorAlert(title: errorTitle)
        }
    }
    
    func errorAlert(title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
}

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
  
    // MARK: Routing
  

  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getSessionButtonPressed(_ sender: UIButton) {
        interactor?.makeRequest(request: .getSession)
    }
  
    func displayData(viewModel: Auth.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displaySession(let viewModel):
            if viewModel.session == nil {
                print(viewModel.errorMessage)
                print("Мы дисплей дате первого контроллера. Сессия равна нулю")
            } else {
                print("Мы дисплей дате первого контроллера. Сессия равна чему-то там")
                router?.routeToRecordsList(segue: nil)
            }
        }
    }
    
    func errorAlert(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: actionTitle, style: .default) { [weak self] (_) in
            //guard let self = self else { return }
            //self.checkInternetConnection()
        }
        
        alertController.addAction(updateAction)
        
        present(alertController, animated: true)
    }
}

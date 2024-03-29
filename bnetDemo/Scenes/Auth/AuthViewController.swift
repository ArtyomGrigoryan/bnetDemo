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

    // MARK: - Public variables
    
    var interactor: AuthBusinessLogic?
    var router: (NSObjectProtocol & AuthRoutingLogic & AuthDataPassing)?
    
    // MARK: - Private variables
    
    private let loadingView = UIView()
    private let activityIndicator = UIActivityIndicatorView()

    // MARK: - Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
  
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

    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivityIndicator()
    }
    
    func displayData(viewModel: Auth.Model.ViewModel.ViewModelData) {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            switch viewModel {
            case .success:
                self.router?.routeToRecordsList(segue: nil)
            case .presentFailure(let errorTitle):
                self.errorAlert(title: errorTitle)
            }
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func getSessionButtonPressed(_ sender: UIButton) {
        showActivityIndicator()
        interactor?.makeRequest(request: .getSession)
    }
 
    // MARK: - Helpers
    
    func errorAlert(title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
    
    func createActivityIndicator() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        loadingView.backgroundColor = .gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        loadingView.isHidden.toggle()
        view.addSubview(loadingView)
    }
    
    func showActivityIndicator() {
        loadingView.isHidden.toggle()
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled.toggle()
    }
    
    func hideActivityIndicator() {
        loadingView.isHidden.toggle()
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled.toggle()
    }
}

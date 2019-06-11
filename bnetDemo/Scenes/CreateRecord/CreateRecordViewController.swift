//
//  CreateRecordViewController.swift
//  bnetDemo
//
//  Created by Артем Григорян on 05/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol CreateRecordDisplayLogic: class {
    func displayData(viewModel: CreateRecord.Model.ViewModel.ViewModelData)
}

class CreateRecordViewController: UIViewController, CreateRecordDisplayLogic {

    // MARK: - Public variables
    
    var interactor: CreateRecordBusinessLogic?
    var router: (NSObjectProtocol & CreateRecordRoutingLogic & CreateRecordDataPassing)?
    
    // MARK: - Private variables
    
    private let loadingView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - @IBOutlets
    
    @IBOutlet private weak var textArea: UITextView!
    
    // MARK: - Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = CreateRecordInteractor()
        let presenter             = CreateRecordPresenter()
        let router                = CreateRecordRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
  
    // MARK: - Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - View lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textArea.becomeFirstResponder()
    }
    
    func displayData(viewModel: CreateRecord.Model.ViewModel.ViewModelData) {
        DispatchQueue.main.async {
            self.removeActivityIndicator()
            switch viewModel {
            case .presentFailure(let error):
                self.errorAlert(title: error)
            case .success:
                self.performSegue(withIdentifier: "RecordsList", sender: nil)
            }
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func createRecordBarButtonPressed(_ sender: UIBarButtonItem) {
        createActivityIndicator()
        let userText = textArea.text!
        interactor?.makeRequest(request: CreateRecord.Model.Request.RequestType.passUserText(userText: userText))
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    func errorAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
    
    func createActivityIndicator() {
        var height: CGFloat {
            let height1 = UIApplication.shared.statusBarFrame.height + ((navigationController?.navigationBar.intrinsicContentSize.height) ?? 0)
            let height2 = navigationController?.navigationBar.frame.height ?? 0
            return UIScreen.main.bounds.height - (height1 + height2)
        }
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = CGPoint(x: view.frame.width / 2, y: height / 2)
        loadingView.backgroundColor = .gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled.toggle()
        navigationController!.view.isUserInteractionEnabled.toggle()
    }
    
    func removeActivityIndicator() {
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
        view.isUserInteractionEnabled.toggle()
        navigationController!.view.isUserInteractionEnabled.toggle()
    }
}

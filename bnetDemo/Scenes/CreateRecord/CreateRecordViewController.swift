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

    var interactor: CreateRecordBusinessLogic?
    var router: (NSObjectProtocol & CreateRecordRoutingLogic & CreateRecordDataPassing)?
    @IBOutlet weak var textArea: UITextView!
    
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
        switch viewModel {
        case .presentError(let error):
            errorAlert(title: error)
        case .success:
            performSegue(withIdentifier: "RecordsList", sender: nil)
        }
    }
    
    @IBAction func createRecordBarButtonPressed(_ sender: UIBarButtonItem) {
        let userText = textArea.text!
        interactor?.makeRequest(request: CreateRecord.Model.Request.RequestType.passUserText(userText: userText))
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func errorAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
}

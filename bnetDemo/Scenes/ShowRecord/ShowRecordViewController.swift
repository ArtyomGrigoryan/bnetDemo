//
//  ShowRecordViewController.swift
//  bnetDemo
//
//  Created by Артем Григорян on 09/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol ShowRecordDisplayLogic: class {
    func displayData(viewModel: ShowRecord.Model.ViewModel.ViewModelData)
}

class ShowRecordViewController: UIViewController, ShowRecordDisplayLogic {

    // MARK: - Public variables
    
    var interactor: ShowRecordBusinessLogic?
    var router: (NSObjectProtocol & ShowRecordRoutingLogic & ShowRecordDataPassing)?
    
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
        let interactor            = ShowRecordInteractor()
        let presenter             = ShowRecordPresenter()
        let router                = ShowRecordRouter()
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
        interactor?.makeRequest(request: .getRecord)
    }
    
    func displayData(viewModel: ShowRecord.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayRecord(let recordBody):
            DispatchQueue.main.async {
                self.textArea.text = recordBody
            }
        }
    }
}

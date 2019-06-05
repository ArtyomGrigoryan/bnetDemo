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
  

  
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    func displayData(viewModel: CreateRecord.Model.ViewModel.ViewModelData) {

    }
}

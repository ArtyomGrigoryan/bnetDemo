//
//  RecordsListViewController.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListDisplayLogic: class {
    func displayData(viewModel: RecordsList.Model.ViewModel.ViewModelData)
}

class RecordsListViewController: UITableViewController, RecordsListDisplayLogic {

    var interactor: RecordsListBusinessLogic?
    var router: (NSObjectProtocol & RecordsListRoutingLogic & RecordsListDataPassing)?

    // MARK: - Object lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = RecordsListInteractor()
        let presenter             = RecordsListPresenter()
        let router                = RecordsListRouter()
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
  
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.makeRequest(request: RecordsList.Model.Request.RequestType.getSession)
    }
  
    func displayData(viewModel: RecordsList.Model.ViewModel.ViewModelData) {
        print("See viewModel from RecordsList \(viewModel)")
    }
}

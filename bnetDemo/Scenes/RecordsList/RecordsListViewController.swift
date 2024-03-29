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

    // MARK: - Public variables
    
    var interactor: RecordsListBusinessLogic?
    var router: (NSObjectProtocol & RecordsListRoutingLogic & RecordsListDataPassing)?
    
    // MARK: - Private variables
    
    private var recordsViewModel = RecordsViewModel(cells: [])

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
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    func displayData(viewModel: RecordsList.Model.ViewModel.ViewModelData) {
        DispatchQueue.main.async {
            switch viewModel {
            case .displayRecords(let recordsViewModel):
                self.recordsViewModel = recordsViewModel
                self.tableView.reloadData()
            case .displayError(let error):
                self.errorAlert(title: error)
            }
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        interactor?.makeRequest(request: .getRecords)
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsViewModel.cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordsListTableViewCell.self), for: indexPath) as! RecordsListTableViewCell
        let cellViewModel = recordsViewModel.cells[indexPath.row]
        
        cell.set(viewModel: cellViewModel)
        
        return cell
    }
    
    // MARK: - Helpers
    
    func errorAlert(title: String) {
        let alertController = UIAlertController(title: title, message: "Повторите попытку.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
}

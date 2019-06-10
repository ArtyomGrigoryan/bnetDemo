//
//  RecordsListPresenter.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

protocol RecordsListPresentationLogic {
    func presentData(response: RecordsList.Model.Response.ResponseType)
}

class RecordsListPresenter: RecordsListPresentationLogic {
    weak var viewController: RecordsListDisplayLogic?
  
    func presentData(response: RecordsList.Model.Response.ResponseType) {
        switch response {
        case .presentResponseData(let records):
            let cells = records.map { (record)  in
                cellViewModel(from: record)
            }
            
            let recordsViewModel = RecordsViewModel(cells: cells)
            
            viewController?.displayData(viewModel: .displayRecords(recordsViewModel: recordsViewModel))
        }
    }
    
    private func cellViewModel(from record: ResponseData2) -> RecordsViewModel.Cell {
        let maxLength = 200
        let convertedDateDa = Date(timeIntervalSince1970: (Double(record.da)! / 1000.0))
        let convertedDateDm = Date(timeIntervalSince1970: (Double(record.dm)! / 1000.0))
        var body = record.body
        
        if body.count > maxLength {
            let range = body.rangeOfComposedCharacterSequences(for: body.startIndex..<body.index(body.startIndex, offsetBy: maxLength))
            body = String(body[range]).appending("...")
        }
        
        return RecordsViewModel.Cell(body: body, da: convertedDateDa, dm: convertedDateDm)
    }
}

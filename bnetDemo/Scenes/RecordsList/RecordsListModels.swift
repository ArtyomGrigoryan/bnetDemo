//
//  RecordsListModels.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum RecordsList {
    enum Model {
        struct Request {
            enum RequestType {
                case getRecords
            }
        }
    
        struct Response {
            enum ResponseType {
                case presentError(error: String)
                case presentResponseData(records: [ResponseData2])
            }
        }
    
        struct ViewModel {
            enum ViewModelData {
                case displayError(error: String)
                case displayRecords(recordsViewModel: RecordsViewModel)
            }
        }
    }
}

struct RecordsViewModel {
    struct Cell: RecordsListCellViewModel {
        var body: String
        var da: Date
        var dm: Date
    }
   
    let cells: [Cell]
}

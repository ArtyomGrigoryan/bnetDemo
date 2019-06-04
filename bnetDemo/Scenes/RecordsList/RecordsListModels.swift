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
                case getSession
            }
        }
    
        struct Response {
            enum ResponseType {
                case presentSession(session: String)
            }
        }
    
        struct ViewModel {
            enum ViewModelData {
                case displaySession(sessionViewModel: SessionViewModel)
            }
        }
    }
}

//
//  CreateRecordModels.swift
//  bnetDemo
//
//  Created by Артем Григорян on 05/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum CreateRecord {
    enum Model {
        struct Request {
            enum RequestType {
                case passUserText(userText: String)
            }
        }
    
        struct Response {
            enum ResponseType {
                case success
                case error(error: String)
            }
        }
    
        struct ViewModel {
            enum ViewModelData {
                case success
                case presentError(error: String)
            }
        }
    }
}

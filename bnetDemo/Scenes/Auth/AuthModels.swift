//
//  AuthModels.swift
//  bnetDemo
//
//  Created by Артем Григорян on 04/06/2019.
//  Copyright (c) 2019 Artyom Grigoryan. All rights reserved.
//

import UIKit

enum Auth {
    enum Model {
        struct Request {
            enum RequestType {
                case getSession
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
                case error(errorTitle: String)
            }
        }
    }
}
//
//struct SessionViewModel {
//    let errorTitle: String?
//}

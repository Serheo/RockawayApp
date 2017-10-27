//
//  NetworkMock.swift
//  RockawayAppTests
//
//  Created by Sergey Shatunov on 10/27/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
import Alamofire
@testable import RockawayApp

class NetworkMock: NetworkService {

    var isOk: Bool = true
    private let fixures = FixtureFabric()
    
    func getBandSearchRequest(query: String,
                              successful: @escaping (BandSearchResult) -> Void,
                              failed: @escaping (Error?) -> Void) -> DataRequest? {
        
        if isOk {
            successful(fixures.searchSuccessfullResult())
        } else {
            failed(nil)
        }
        return nil
    }
    
    func getBandProfile(itemId: String,
                        successful: @escaping (BandProfileResult) -> Void,
                        failed: @escaping (Error?) -> Void) {
        
        if isOk {
            successful(fixures.profileSuccessfullResult())
        } else {
            failed(nil)
        }
        
    }

}

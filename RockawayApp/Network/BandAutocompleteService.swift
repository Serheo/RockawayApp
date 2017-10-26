//
//  BandAutocompleteService.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
import Alamofire

class BandAutocompleteService {

    private let network: NetworkService
    private var lastRequest: DataRequest?

    init(network: NetworkService) {
        self.network = network
    }

    func getBandSearchRequest(query: String,
                              successful: @escaping (BandSearchResult) -> Void,
                              failed: @escaping (Error?) -> Void) {

        lastRequest?.cancel()
        lastRequest = network.getBandSearchRequest(query: query, successful: successful, failed: failed)
    }
}

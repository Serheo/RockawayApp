//
//  NetworkService.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

import UIKit
import Alamofire

protocol NetworkService: class {
    func getBandSearchRequest(query: String,
                              successful: @escaping (BandSearchResult) -> Void,
                              failed: @escaping (Error?) -> Void) -> DataRequest?

    func getBandProfile(itemId: String,
                        successful: @escaping (BandProfileResult) -> Void,
                        failed: @escaping (Error?) -> Void)
}

final class NetworkHttpService: NetworkService {
    private let router: NetworkRouteDispatcher

    init(baseUrl: String, secretKey: String) {
        self.router = NetworkRouteDispatcher(baseURL: baseUrl, secretKey: secretKey)
    }

    @discardableResult
    func getBandSearchRequest(query: String,
                              successful: @escaping (BandSearchResult) -> Void,
                              failed: @escaping (Error?) -> Void) -> DataRequest? {

        let route = router.route(for: .search(query: query))
        let request = performObjectRequest(router: route, successful: successful, failed: failed)
        return request
    }

    func getBandProfile(itemId: String,
                        successful: @escaping (BandProfileResult) -> Void,
                        failed: @escaping (Error?) -> Void) {

        let route = router.route(for: .profile(itemId: itemId))
        performObjectRequest(router: route, successful: successful, failed: failed)
    }

    @discardableResult
    private func performObjectRequest<T: Decodable>(router: URLRequestConvertible,
                                                    successful: @escaping (T) -> Void,
                                                    failed: @escaping (Error?) -> Void) -> DataRequest? {
        var request: URLRequest
        do {
            request = try router.asURLRequest()
        } catch let error {
            failed(error)
            return nil
        }

        return Alamofire.request(request).validate().responseDecodableObject { (response: DataResponse<T>)  in
            if response.result.isFailure {
                failed(response.result.error)
                return
            }

            guard let result = response.result.value else {
                failed(nil)
                return
            }

            successful(result)
        }
    }
}

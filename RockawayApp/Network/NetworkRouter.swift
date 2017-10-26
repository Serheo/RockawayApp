//
//  NetworkRouter.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
import Alamofire

enum NetworkRouteDirection {
    case search(query: String)
    case profile(itemId: String)
}

final class NetworkRouteDispatcher {
    private let baseURL: String
    private var secretKey: String

    init(baseURL: String, secretKey: String) {
        self.baseURL = baseURL
        self.secretKey = secretKey
    }

    func route(for direction: NetworkRouteDirection) -> URLRequestConvertible {
        return NetworkRoute(baseURL: baseURL, secretKey: secretKey, direction: direction)
    }
}

final class NetworkRoute: URLRequestConvertible {
    private let direction: NetworkRouteDirection
    private let baseURL: String
    private var secretKey: String

    init(baseURL: String, secretKey: String, direction: NetworkRouteDirection) {
        self.direction = direction
        self.baseURL = baseURL
        self.secretKey = secretKey
    }

    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch direction {
            case let .search(query):
                return ("/search/band_name/\(query)", ["api_key": secretKey])
            case let .profile(itemId):
                return ("/band/\(itemId)", ["api_key": secretKey])
            }
        }()

        let url = try baseURL.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))

        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}

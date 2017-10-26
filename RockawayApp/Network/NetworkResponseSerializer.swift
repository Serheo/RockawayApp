//
//  NetworkResponseSerializer.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
import Alamofire

extension DataRequest {

    @discardableResult
    func responseDecodableObject<T: Decodable>(queue: DispatchQueue? = nil,
                                               completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {

        let responseSerializer = DataResponseSerializer<T> { _, _, data, error in
            if let err = error {
                return .failure(err)
            }

            guard let data = data else {
                let error = AFError.responseValidationFailed(reason: .dataFileNil)
                return .failure(error)
            }

            let jsonDecoder = JSONDecoder()
            do {
                let result = try jsonDecoder.decode(T.self, from: data)
                return .success(result)
            } catch let err {
                return .failure(err)
            }
        }

        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

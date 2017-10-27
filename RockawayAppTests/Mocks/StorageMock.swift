//
//  StorageMock.swift
//  RockawayAppTests
//
//  Created by Sergey Shatunov on 10/27/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
@testable import RockawayApp

final class StorageMock: ResultStorage {

    private var result: BandSearchResult?
    init(result: BandSearchResult?) {
        self.result = result
    }
    
    func save(item: BandSearchResult) {
        
    }
    
    func get(completion: @escaping (BandSearchResult) -> Void) {
        if let result = result {
            completion(result)
        }
    }
    
}

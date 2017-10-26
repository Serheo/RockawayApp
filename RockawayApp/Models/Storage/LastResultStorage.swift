//
//  LastResultStorage.swift
//  Rockaway
//
//  Created by Sergey Shatunov on 10/24/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

protocol ResultStorage: class {
    func save(item: BandSearchResult)
    func get(completion: @escaping (BandSearchResult) -> Void)
}

final class LastResultStorage: ResultStorage {
    private let objectKey = "app.storage.LastResultStorageKey"
    private let queue = DispatchQueue.global(qos: .background)

    func save(item: BandSearchResult) {
        queue.async { [weak self] in
            guard let sSelf = self else {
                return
            }

            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(item) {
                UserDefaults.standard.setValue(encoded, forKey: sSelf.objectKey)
                UserDefaults.standard.synchronize()
            }
        }
    }

    func get(completion: @escaping (BandSearchResult) -> Void) {
        queue.async { [weak self] in
            guard let sSelf = self else {
                return
            }
            if let objects = UserDefaults.standard.value(forKey: sSelf.objectKey) as? Data {
                let decoder = JSONDecoder()
                if let saved = try? decoder.decode(BandSearchResult.self, from: objects) {
                    DispatchQueue.main.async {
                        completion(saved)
                    }
                }
            }
        }
    }
}

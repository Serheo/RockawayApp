//
//  FixtureFabric.swift
//  RockawayAppTests
//
//  Created by Sergey Shatunov on 10/27/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
@testable import RockawayApp

final class FixtureFabric {
    
    func profileSuccessfullResult() -> BandProfileResult {
        return fromJson(name: "SearchProfileOK", structureType: BandProfileResult.self)
    }
    
    func searchSuccessfullResult() -> BandSearchResult {
        return fromJson(name: "SearchResultsOK", structureType: BandSearchResult.self)
    }

    private func fromJson<T: Codable>(name: String, structureType: T.Type) -> T {
        
        func loadJson(name: String) -> Data {
            if let url = Bundle(for: FixtureFabric.self).url(forResource: name, withExtension: "json") {
                var data: Data
                do {
                    data = try Data(contentsOf: url)
                } catch {
                    fatalError("File is broken")
                }
                return data
            } else {
                fatalError("Filepath not found")
            }
            return Data()
        }
        
        let data = loadJson(name: name)
        let response: T
        do {
            response = try JSONDecoder().decode(structureType, from: data)
        } catch {
            fatalError("File is broken")
        }
        
        return response
    }
    
}

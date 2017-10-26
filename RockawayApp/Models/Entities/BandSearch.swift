//
//  BandSearch.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

struct BandSearchResult: Codable {
    var status: String
    var data: BandSearchData
}

struct BandSearchData: Codable {
    var query: String
    var searchResult: [BandResultDataSearchResult]

    enum CodingKeys: String, CodingKey {
        case query
        case searchResult = "search_results"
    }
}

struct BandResultDataSearchResult: Codable {
    var name: String
    var itemId: String
    var genre: String
    var country: String

    enum CodingKeys: String, CodingKey {
        case name
        case itemId = "id"
        case genre
        case country
    }
}

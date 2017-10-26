//
//  BandProfile.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

struct BandProfileResult: Codable {
    var status: String
    var data: BandProfileData
}

struct BandProfileData: Codable {
    var itemId: String
    var photo: String?
    var bio: String
    var bandName: String
    var discography: [BandProfileAlbum]
    var details: BandProfileDetails

    enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case photo
        case bio
        case bandName = "band_name"
        case discography
        case details
    }
}

struct BandProfileAlbum: Codable {
    var itemId: String
    var title: String
    var albumType: String
    var year: String

    enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case title
        case albumType = "type"
        case year
    }
}

struct BandProfileDetails: Codable {
    var countryOfOrigin: String
    var genre: String
    var yearActive: String

    enum CodingKeys: String, CodingKey {
        case countryOfOrigin = "country of origin"
        case genre
        case yearActive = "years active"
    }
}

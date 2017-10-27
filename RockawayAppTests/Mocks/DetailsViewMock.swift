//
//  BandProfileViewMock.swift
//  RockawayAppTests
//
//  Created by Sergey Shatunov on 10/27/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
import XCTest
@testable import RockawayApp

class DetailsViewMock: DetailsView {
    
    var expectatonOnShowProfile: XCTestExpectation?
    var expectatonOnSetTitle: XCTestExpectation?
    var expectatonOnError: XCTestExpectation?

    func show(profile: BandProfileResult) {
        expectatonOnShowProfile?.fulfill()
    }
    
    func show(error: Error?) {
        expectatonOnError?.fulfill()
    }
    
    func setProfileTitle(title: String) {
        expectatonOnSetTitle?.fulfill()
    }
    
    func showLoadingIndicator() {
        
    }
    func hideLoadingIndicator() {
        
    }
}

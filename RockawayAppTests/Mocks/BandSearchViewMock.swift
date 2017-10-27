//
//  BandSearchViewMock.swift
//  RockawayAppTests
//
//  Created by Sergey Shatunov on 10/27/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
import XCTest
@testable import RockawayApp

class BandSearchViewMock: BandSearchView {

    var expectatonOnShow: XCTestExpectation?
    var expectatonOnSetTitle: XCTestExpectation?
    var lastResult: [BandResultDataSearchResult]?
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func show(result: [BandResultDataSearchResult]) {
        self.lastResult = result
        expectatonOnShow?.fulfill()
    }
    
    func setSearchTitle(text: String) {
        expectatonOnSetTitle?.fulfill()
    }
}

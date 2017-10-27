//
//  DetailsPresenterTests.swift
//  RockawayAppTests
//
//  Created by Sergey Shatunov on 10/27/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import XCTest
@testable import RockawayApp

class DetailsPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testProfileSuccess() {
        let network = NetworkMock()
        let view = DetailsViewMock()
        let startItem = FixtureFabric().searchSuccessfullResult().data.searchResult.first!
        let presenter = DetailsPresenter(bandToShow: startItem,
                                         network: network,
                                         view: view)
        
        let expect = expectation(description: "Should set title at the start")
        view.expectatonOnSetTitle = expect
        
        let expectProfile = expectation(description: "Should show profile")
        view.expectatonOnShowProfile = expectProfile
        
        presenter.viewDidLoad()
        
        waitForExpectations(timeout: 15, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
    
    func testProfileFailed() {
        let network = NetworkMock()
        network.isOk = false
        let view = DetailsViewMock()
        let startItem = FixtureFabric().searchSuccessfullResult().data.searchResult.first!
        let presenter = DetailsPresenter(bandToShow: startItem,
                                         network: network,
                                         view: view)
        
        let expect = expectation(description: "Should set title at the start")
        view.expectatonOnSetTitle = expect
        
        let expectError = expectation(description: "Should show error")
        view.expectatonOnError = expectError
        
        presenter.viewDidLoad()
        
        waitForExpectations(timeout: 15, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
}

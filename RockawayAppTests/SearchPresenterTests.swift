//
//  SearchPresenterTests.swift
//  RockawayAppTests
//
//  Created by Sergey Shatunov on 10/27/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import XCTest
@testable import RockawayApp

class SearchPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchScreenWithHistory() {
        let network = NetworkMock()
        let storage = StorageMock(result: FixtureFabric().searchSuccessfullResult())
        let view = BandSearchViewMock()
        let presenter = BandSearchPresenter(network: network, storage: storage, view: view)
        
        let expect = expectation(description: "Should call showResult to show history")
        view.expectatonOnShow = expect
        
        presenter.viewDidLoad()
        
        waitForExpectations(timeout: 15, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
    
    func testSearchScreenWithNoHistory() {
        let network = NetworkMock()
        
        let storage = StorageMock(result: nil)
        let view = BandSearchViewMock()
        let presenter = BandSearchPresenter(network: network, storage: storage, view: view)
        
        let expect = expectation(description: "Should not call showResult")
        expect.fulfill() // second call will raise anexception
        view.expectatonOnShow = expect
        
        presenter.viewDidLoad()
        
        waitForExpectations(timeout: 15, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
    
    func testSearchQuery() {
        let network = NetworkMock()
        
        let storage = StorageMock(result: nil)
        let view = BandSearchViewMock()
        let presenter = BandSearchPresenter(network: network, storage: storage, view: view)
        
        let expect = expectation(description: "Should call showResult with result")
        view.expectatonOnShow = expect
        
        presenter.search(query: "search")
        
        XCTAssert(view.lastResult?.isEmpty == false, "Should find elements")
        waitForExpectations(timeout: 15, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
    
    func testSearchEmptyQuery() {
        let network = NetworkMock()
        
        let storage = StorageMock(result: nil)
        let view = BandSearchViewMock()
        let presenter = BandSearchPresenter(network: network, storage: storage, view: view)
        
        let expect = expectation(description: "Should call showResult with result")
        view.expectatonOnShow = expect
        
        presenter.search(query: nil)
        
        XCTAssert(view.lastResult?.isEmpty == true, "Should not find elements")
        waitForExpectations(timeout: 15, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
}

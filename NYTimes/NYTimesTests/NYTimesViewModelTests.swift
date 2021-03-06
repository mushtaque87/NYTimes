//
//  NYTimesNetworkTests.swift
//  NYTimesTests
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = HomeViewModel(networkManager:NetworkManager(httpClient:HttpClient(session: URLSession(configuration: URLSessionConfiguration.default))), dataManager: Datamanager())
        
    }
    
    func testUrlFormation() {
        let url = sut.generateURL(with: "Singapore Airlines")
        XCTAssertEqual(url, URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fxUVDH9wKLwHUheA1OBZKY9zXxa15yvM&q=Singapore%20Airlines&page=0"), "String didnt Match")
    }
    
    func testSearch() {
        sut.search(for: "Singapore")
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut =  nil
        super.tearDown()
    }
    
    
}

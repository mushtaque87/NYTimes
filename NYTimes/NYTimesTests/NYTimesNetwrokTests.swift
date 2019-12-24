//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesNetwrokTests: XCTestCase {

    var sut: HttpClient!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = HttpClient(session: URLSession(configuration: .default))
        
    }

    //**** You can test Network calls directly, though they will be slow so they should be kept seperately in seperate Tests. ****
    func testSearchAPI() {
        let promise = expectation(description: "Status Code: 200")
        let url =
            URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fxUVDH9wKLwHUheA1OBZKY9zXxa15yvM")!
       
        sut.get(url:url) { (data, response,  error) in
            print("error aya: \(error)" )
            if let error = error {
                 XCTFail("Error: \(error.localizedDescription)")
                 return
               } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                 if statusCode == 200 {
                   // 2
                     print("statuscode: \(statusCode)" )
                   promise.fulfill()
                 } else {
                   XCTFail("Status code: \(statusCode)")
                 }
            }
        }
       wait(for: [promise], timeout: 10)
    }
    
    //**** You can test Network response by mocking and using stub response. ****
    func testJsonDecoding() {
        
        let data = Helper.readJsonFile(at: "articles", ofType: ".json")
        do {
            let articles = try JSONDecoder.decodeData(data, of: Article.self)
            print("Article \(articles)")
        } catch  {
            print("Throwable Error \(error)")
            XCTFail("Throwable Error \(error)")
        }
    }
        
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut =  nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

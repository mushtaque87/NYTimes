//
//  NYTimesDataManagerTests.swift
//  NYTimesTests
//
//  Created by Mushtaque Ahmed on 12/22/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesDataManagerTests: XCTestCase {
    
    var sut: Datamanager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = Datamanager()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut =  nil
        super.tearDown()
    }

    func testAppendDoc() {
       let data = Helper.readJsonFile(at: "articles", ofType: ".json")
             do {
                let articles : Article = try JSONDecoder.decodeData(data, of: Article.self) as! Article
                sut.appendData(with: (articles.response?.docs)!)
             } catch  {
                 print("Throwable Error \(error)")
                 XCTFail("Throwable Error \(error)")
        }
        XCTAssertEqual(sut.getDocCount(), 1)
        
    }
     
    
    func testGetDoc() {
           let data = Helper.readJsonFile(at: "articles", ofType: ".json")
                  do {
                     let articles : Article = try JSONDecoder.decodeData(data, of: Article.self) as! Article
                     sut.appendData(with: (articles.response?.docs)!)
                  } catch  {
                      print("Throwable Error \(error)")
                      XCTFail("Throwable Error \(error)")
             }
        XCTAssertNotNil(sut.getDoc(for: 0))
        
    }
    
    func testClearAllDoc() {
        let data = Helper.readJsonFile(at: "articles", ofType: ".json")
                  do {
                     let articles : Article = try JSONDecoder.decodeData(data, of: Article.self) as! Article
                     sut.appendData(with: (articles.response?.docs)!)
                  } catch  {
                      print("Throwable Error \(error)")
                      XCTFail("Throwable Error \(error)")
             }
        XCTAssertNotNil(sut.getDoc(for: 0))
        sut.cleanAllData()
        XCTAssertNil(sut.getDoc(for: 0))
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

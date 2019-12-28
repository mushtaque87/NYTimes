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
    
    // var sut: HttpClient!
    var sut: NetworkManager!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        //sut = HttpClient(session: URLSession(configuration: .default))
        
        let url =  URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fxUVDH9wKLwHUheA1OBZKY9zXxa15yvM")!
        
        
        //        let viewModel = HomeViewModel(networkManager: sut, dataManager: Datamanager())
        //        let url = viewModel.generateURL(with: "Singapore Airlines")
        
        let urlResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        
        let data = Helper.readJsonFile(at: "articles", ofType: ".json")
        
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        
        sut = NetworkManager(httpClient: HttpClient(session: sessionMock))
        
        
        
    }
    
    //**** You can test Network calls directly, though they will be slow so they should be kept seperately in seperate Tests. ****
    //  func testSearchAPI() {
    //        let promise = expectation(description: "Status Code: 200")
    //        let url =
    //            URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fxUVDH9wKLwHUheA1OBZKY9zXxa15yvM")!
    //
    //        sut.httpClient.get(url:url) { (data, response,  error) in
    //            print("error aya: \(error)" )
    //            if let error = error {
    //                 XCTFail("Error: \(error.localizedDescription)")
    //                 return
    //               } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
    //                 if statusCode == 200 {
    //                   // 2
    //                     print("statuscode: \(statusCode)" )
    //                   promise.fulfill()
    //                 } else {
    //                   XCTFail("Status code: \(statusCode)")
    //                 }
    //            }
    //        }
    //       wait(for: [promise], timeout: 10)
    //    }
    
    func testSearchAPI_UsingMock() {
        
        let promise = expectation(description: "Status Code: 200")
        let url =  URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fxUVDH9wKLwHUheA1OBZKY9zXxa15yvM")!
        
        let dataTask = sut.httpClient.session.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                do {
                    let articles : Article = try CustomDecoder.decodeData(data, of: Article.self) as! Article
                    XCTAssertEqual(articles.status, "OK" , "article status is \(articles.status)")
                } catch  {
                    print("Throwable Error \(error)")
                    XCTFail("Throwable Error \(error)")
                }
            }
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        //  XCTAssertEqual(sut.searchResults.count, 3, "Didn't parse 3 items from fake response")
    }
    
    //**** You can test Network response by mocking and using stub response. ****
    func testJsonDecoding() {
        
        let data = Helper.readJsonFile(at: "articles", ofType: ".json")
        do {
            let articles : Article = try CustomDecoder.decodeData(data, of: Article.self) as! Article
            print("Article \(articles)")
            XCTAssertEqual(articles.status, "OK" , "article status is \(articles.status)")
            
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
    
}


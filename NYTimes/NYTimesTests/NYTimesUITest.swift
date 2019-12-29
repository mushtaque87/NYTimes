//
//  NYTimesUITest.swift
//  NYTimesTests
//
//  Created by Mushtaque Ahmed on 12/28/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import XCTest
import UIKit

@testable import NYTimes

class NYTimesUITest: XCTestCase {

    var sut: HomeViewController!
    var tableview : UITableView?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
       // sut = UIStoryboard(name: "Main", bundle: nil)
       // .instantiateInitialViewController() as? HomeViewController
        
        //sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController")
        sut =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        let url =  URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fxUVDH9wKLwHUheA1OBZKY9zXxa15yvM")!

        let urlResponse = HTTPURLResponse(
               url: url,
               statusCode: 200,
               httpVersion: nil,
               headerFields: nil)
               
               let data = Helper.readJsonFile(at: "articles", ofType: ".json")
               
               let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)

               let networkManager = NetworkManager(httpClient: HttpClient(session: sessionMock))
        
                sut.viewModel = HomeViewModel(networkManager:networkManager , dataManager: Datamanager())
                self.tableview = self.sut.articleTableView
    }

    func testTableViewRows() {
        
        let promise = expectation(description: "Status Code: 200")
        let url =  URL(string: "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fxUVDH9wKLwHUheA1OBZKY9zXxa15yvM")!
//         let tableview = self.sut.articleTableView
        
        let dataTask = sut.viewModel.networkManager.httpClient.session.dataTask(with: url) {
           data, response, error in
           if let error = error {
             print(error.localizedDescription)
           } else if let httpResponse = response as? HTTPURLResponse,
             httpResponse.statusCode == 200 {
                 do {
                    let articles : Article = try CustomDecoder.decodeData(data, of: Article.self) as! Article
                    XCTAssertEqual(articles.status, "OK" , "article status is \(articles.status)")
                   
                    self.sut.viewModel.dataManager.appendData(with: (articles.response?.docs)!)
                    XCTAssertEqual( self.sut.viewModel.dataManager.docs.count, 1)
                   
                    XCTAssertEqual(self.tableview!.dataSource?.tableView(self.tableview!, numberOfRowsInSection: 0) , 1)
                    
                       } catch  {
                           print("Throwable Error \(error)")
                           XCTFail("Throwable Error \(error)")
                       }
           }
           promise.fulfill()
         }
         dataTask.resume()
         wait(for: [promise], timeout: 5)
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }


}

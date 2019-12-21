//
//  HTTPClient.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    init(session: URLSession)
}

class HttpClient : URLSession {
    
    typealias completeClosure = ( _ data: Data? ,_ response: URLResponse?, _ error: Error?)->Void
    private let session: URLSession
    
    required init(session: URLSession) {
        self.session = session 
       }
    
    func get( url: URL, callback: @escaping completeClosure ) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let task = self.session.dataTask(with: url) {(data, response, error) in
            callback(data, response , error)
        }
        print("taskResume")
        task.resume()
    }
}

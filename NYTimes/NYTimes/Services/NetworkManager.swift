//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation

protocol Search {
    func search(_ url:URL)
}



class NetworkManager : NSObject , Search {
    let httpClient : HttpClient
    
    init(httpClient:HttpClient) {
        self.httpClient = httpClient
    }
    
    func search(_ url: URL) {
        httpClient.get(url: url) { (success, response , error) in
        }
    }
    
}

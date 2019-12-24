//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation

protocol SearchDelegate {
    func search(_ url: URL,
                onSuccess successCompletionHandler: @escaping ([Docs]) -> Void)
    
}



class NetworkManager : NSObject , SearchDelegate {
    let httpClient : HttpClient
    
    init(httpClient:HttpClient) {
        self.httpClient = httpClient
    }
    
    func search(_ url: URL,
                onSuccess successCompletionHandler: @escaping ([Docs]) -> Void) {
        
          httpClient.get(url: url) { (data , response , error) in
            
            do {
                let articles : Article = try JSONDecoder.decodeData(data, of: Article.self) as! Article
                    if let docs = articles.response?.docs {
                                                  successCompletionHandler(docs)
                        }
                   } catch  {
                       print("Throwable Error \(error)")
                     
                   }
        }
    
    }
}

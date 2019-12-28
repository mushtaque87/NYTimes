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
                onSuccess successCompletionHandler: @escaping ([Docs]) -> Void, onFailure: @escaping(Error) -> Void)
    
}



class NetworkManager : NSObject , SearchDelegate {
    let httpClient : HttpClient
    
    init(httpClient:HttpClient) {
        self.httpClient = httpClient
    }
    
    func search(_ url: URL,
                onSuccess successCompletionHandler: @escaping ([Docs]) -> Void,
                onFailure: @escaping(Error) -> Void) {
        
        httpClient.get(url: url) { (data , response , error) in
            if error != nil  {
                onFailure(error!)
            } else {
                
                do {
                    let articles : Article = try CustomDecoder.decodeData(data, of: Article.self) as! Article
                    
                    if let docs = articles.response?.docs {
                        successCompletionHandler(docs)
                    }
                } catch  {
                    print("Throwable Error \(error)")
                    
                }
            }
        }
        
    }
}

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
            
             if (response as? HTTPURLResponse)?.statusCode == 200 {
                do {
                    let content : Article = try JSONDecoder().decode(Article.self, from: data!)
                    if let docs = content.response?.docs {
                                  successCompletionHandler(docs)
                                }
                            }
                            catch let DecodingError.dataCorrupted(context) {
                                print("Context:  \(context.debugDescription)")
                            } catch let DecodingError.keyNotFound(key, context) {
                               print("Key: \(key) context:  \(context.debugDescription)")
                            } catch let DecodingError.valueNotFound(value, context) {
                               print("Value: \(value) context:  \(context.debugDescription)")
                            } catch let DecodingError.typeMismatch(type, context)  {
                               print("Type: \(type) context:  \(context.debugDescription)")
                            }
                            catch {
                                print("HTTP error: \(error.localizedDescription)")
                            }
            }
        }
    }
    
}

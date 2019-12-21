//
//  Constants.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation

import Foundation

struct Constants {

     static let KEY = "fxUVDH9wKLwHUheA1OBZKY9zXxa15yvM"
    
    struct ServerApi {

           static let baseUrl = Environment().configuration(PlistKey.NYTimesDevBaseURL)
    }
}

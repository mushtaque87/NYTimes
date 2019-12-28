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
        //All the micro service APIs can be kept at one place.
        static let baseUrl = Environment().configuration(PlistKey.NYTimesDevBaseURL)
    }
}

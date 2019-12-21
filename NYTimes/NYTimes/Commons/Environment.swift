//
//  Environment.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation

public enum PlistKey {
    case NYTimesDevBaseURL
    case NYTimesTestBaseURL
    case NYTimesProdBaseURL
  

    func value() -> String {
        switch self {
        case .NYTimesDevBaseURL:
            return "nyTimes_dev_base_url"
        case .NYTimesTestBaseURL:
            return "nyTimes_test_base_url"
        case .NYTimesProdBaseURL:
            return "nyTimes_prod_auth_url"
        }
    }
}

public struct Environment {

fileprivate var infoDict: [String: Any] {
    get {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }
}

public func configuration(_ key: PlistKey) -> String {
      switch key {
      case .NYTimesDevBaseURL:
          return infoDict[PlistKey.NYTimesDevBaseURL.value()] as! String
    case .NYTimesTestBaseURL:
        return infoDict[PlistKey.NYTimesTestBaseURL.value()] as! String
    case .NYTimesProdBaseURL:
        return infoDict[PlistKey.NYTimesProdBaseURL.value()] as! String
      }
  }
}

//
//  DataManager.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/22/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation

enum MoveArticle  {
    case next
    case previous
}

struct CurrentDoc {
    var currentIndex : Int?
    var currentDoc : Docs?
}

protocol DataDelegate {

    associatedtype D
    var docs : [D] {get set}
    func appendData(with data:[D])
    func cleanAllData()
    func getDoc(for index:Int) -> D?
    func getCurrentIndex() -> Int
    func setNextIndex(_ moveTo:MoveArticle)
    func setCurrentIndex(_ index: Int)
    func getDocCount() -> Int
    func getCurrentDoc() -> CurrentDoc
}

class Datamanager : NSObject , DataDelegate {
  
    
    typealias D = Docs
    var docs = [Docs]()
    var currentIndex = 0
    
    override init() {
        super.init()
    }

    
    func appendData(with data: [Docs]) {
        self.docs.append(contentsOf: data)
    }
    
    func getDoc(for index:Int) -> D? {
        guard (0..<self.docs.count).contains(index) else {
            return nil
        }
        return self.docs[index]
    }
    func cleanAllData() {
        self.docs.removeAll()
    }
    
    func getCurrentIndex() -> Int {
        return currentIndex
    }
    
    func getCurrentDoc() -> CurrentDoc {
          return CurrentDoc(currentIndex: currentIndex, currentDoc: getDoc(for: currentIndex))
    }
    func setCurrentIndex(_ index: Int) {
        self.currentIndex = index
    }
    func setNextIndex(_ moveTo:MoveArticle) {
        switch moveTo {
        case .next:
            guard currentIndex == self.docs.count else {
                          return
            }
            currentIndex += 1
            
        default:
            guard currentIndex > 0 else {
                return
            }
            currentIndex += -1
        }
    }
    
    func getDocCount() -> Int {
        self.docs.count
    }
    
}

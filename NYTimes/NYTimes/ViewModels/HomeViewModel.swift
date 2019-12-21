//
//  HomeViewModels.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation
import UIKit

protocol HomeVCDelegate {
    func search(for text:String)
    func getWebPageUrl()
    
}

class HomeViewModel : NSObject , HomeVCDelegate {

    let networkManager : NetworkManager
    
    init(networkManager : NetworkManager) {
        self.networkManager = networkManager
    }
    
    
    func search(for text:String) {
        self.networkManager.search(URL(string:String(format: text.count == 0 ? "%@" : "%@/%@",  Constants.ServerApi.baseUrl+Constants.KEY,"q=\(text)&page=0"))!)
    }
    
    func getWebPageUrl() {
        print("getWebPageUrl")
    }
    
    
    
}

//
//extension HomeViewModels : UITableViewDelegate , UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
    
    
//}

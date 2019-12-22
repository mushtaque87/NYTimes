//
//  HomeViewModels.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation
import UIKit



class HomeViewModel : NSObject {

    let networkManager : NetworkManager
    let dataManager : Datamanager
    weak var delegate: HomeVCDelegate?
    
    init(networkManager : NetworkManager , dataManager:Datamanager) {
        self.networkManager = networkManager
        self.dataManager = dataManager
    }
    
    func generateURL(with searchText:String = "") -> URL {
        var encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
        return URL(string:String(format: searchText.count == 0 ? "%@" : "%@&%@",  Constants.ServerApi.baseUrl+Constants.KEY,"q=\(encodedSearchText)&page=0"))!
    }
    
    func search(for text:String) {
        let url = generateURL(with: text)
        self.networkManager.search(url , onSuccess: { docs in
          
            self.dataManager.appendData(with: docs)
             DispatchQueue.main.async {
                self.delegate?.reloadTableView()
            }
        })
    }
    
}


extension HomeViewModel : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // The cell has to be dynamic based on the asbtract text count.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.dataManager.getDocCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        if let doc = self.dataManager.getDoc(for: indexPath.row) {
            cell.headlineLabel.text = doc.headline?.main
            cell.abstractLabel.text = doc.abstract
            cell.sectionLabel.text = doc.section_name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dataManager.setCurrentIndex(indexPath.row)
        delegate?.showDetailPageVC(self.dataManager.getCurrentDoc())
    }
}

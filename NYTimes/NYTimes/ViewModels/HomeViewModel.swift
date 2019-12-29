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
    var numberOfRowsforSectionOne = 0
    lazy var histories = [String]()
    
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
        }, onFailure: { error in
            print("Error \(error)")
        })
    }
    
}


extension HomeViewModel : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0) {
            return 40
        }
        return 100 // The cell has to be dynamic based on the asbtract text count.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return histories.count
        }
        return self.dataManager.getDocCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?)!
            cell.textLabel?.text =  self.histories[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
            if let doc = self.dataManager.getDoc(for: indexPath.row) {
                cell.headlineLabel.text = doc.headline?.main
                cell.abstractLabel.text = doc.abstract
                cell.sectionLabel.text = doc.section_name
            }
            return cell
        }
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if(indexPath.section == 0) {
        delegate?.setSearchtext(text: self.histories[indexPath.row])
       
       } else {
        self.dataManager.setCurrentIndex(indexPath.row)
        delegate?.showDetailPageVC(self.dataManager.getCurrentDoc())
        }
    }
}

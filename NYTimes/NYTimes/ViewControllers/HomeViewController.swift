//
//  ViewController.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import UIKit

protocol HomeVCDelegate : class {
    func search(for text:String)
    func showDetailPageVC(_ doc:CurrentDoc)
    func reloadTableView()
    func setSearchtext(text:String)
}


class HomeViewController: UIViewController , HomeVCDelegate  {
   
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let cellReuseIdentifier = "cell"
    
    var viewModel = HomeViewModel(networkManager:NetworkManager(httpClient:HttpClient(session: URLSession(configuration: URLSessionConfiguration.default))),
                                  dataManager: Datamanager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.articleTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.articleTableView?.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        self.articleTableView?.dataSource = viewModel
        self.articleTableView?.delegate = viewModel
        self.searchBar.delegate = self
        viewModel.delegate = self
        viewModel.search(for: "")
    }
    override func viewDidAppear(_ animated: Bool) {
        searchBar.resignFirstResponder()
    }
    
    func search(for text: String) {
        activityIndicator.startAnimating()
        viewModel.search(for: text)
    }
    
    func showDetailPageVC(_ doc:CurrentDoc) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailView") as? DetailViewController
        vc?.currentDoc = doc
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func reloadTableView() {
        activityIndicator.stopAnimating()
        self.articleTableView.reloadData()
    }
    
    func setSearchtext(text: String) {
        searchBar.text = text
        
       }
       
}

extension HomeViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.viewModel.histories = UserDefaults.standard.fetchHistoryFromDefault(for: "History")
        self.articleTableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.viewModel.histories.removeAll()
         self.articleTableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.numberOfRowsforSectionOne = searchText.count
        self.articleTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            self.viewModel.histories.removeAll()
            self.articleTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UserDefaults.standard.setHistoryInDefault(for: "History", with: searchBar.text ?? "")
        self.viewModel.dataManager.cleanAllData()
        self.search(for: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}



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
}


class HomeViewController: UIViewController , HomeVCDelegate  {
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let viewModel = HomeViewModel(networkManager:NetworkManager(httpClient:HttpClient(session: URLSession(configuration: URLSessionConfiguration.default))),
                                  dataManager: Datamanager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.articleTableView?.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        self.articleTableView?.dataSource = viewModel
        self.articleTableView?.delegate = viewModel
        self.searchBar.delegate = self
        viewModel.delegate = self
        viewModel.search(for: "")
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
}

extension HomeViewController : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.dataManager.cleanAllData()
        self.search(for: searchBar.text!)
    }
}



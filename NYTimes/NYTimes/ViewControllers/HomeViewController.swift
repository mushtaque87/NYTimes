//
//  ViewController.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel(networkManager:NetworkManager(httpClient:HttpClient(session: URLSession(configuration: URLSessionConfiguration.default))))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.search(for: "")
    }


}


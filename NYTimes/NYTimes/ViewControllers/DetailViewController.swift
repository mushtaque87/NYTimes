//
//  DetailViewController.swift
//  NYTimes
//
//  Created by Mushtaque Ahmed on 12/22/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import UIKit
import WebKit


class DetailViewController: UIViewController , UIWebViewDelegate , WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var currentDoc : CurrentDoc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(currentDoc?.currentDoc?.web_url)
        let request = URLRequest(url: URL(string: (currentDoc?.currentDoc?.web_url)!)!)
        webView.navigationDelegate = self
        webView.load(request)
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

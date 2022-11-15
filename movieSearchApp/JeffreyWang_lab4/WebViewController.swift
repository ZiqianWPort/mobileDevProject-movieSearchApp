//
//  WebViewController.swift
//  JeffreyWang_lab4
//
//  Created by Ziqian Wang on 10/30/22.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var myURLRequest: URLRequest?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        webView.load(myURLRequest!)
        webLoading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        webLoading.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        webLoading.stopAnimating()
        webLoading.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


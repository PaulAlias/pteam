//
//  ViewController.swift
//  TabBar
//
//  Created by Павел Алешин on 18/02/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var forwardButn: UIButton!
    @IBOutlet weak var backButn: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let homePage = "https://www.yandex.ru"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        textField.delegate = self
        webView.navigationDelegate = self
        
        textField.text = homePage
      
       webView.load(request)
       webView.allowsBackForwardNavigationGestures  = true
        
    }

    @IBAction func forwardButnAction(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func backButnAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
}


extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString  = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        textField.text = webView.url?.absoluteString
        backButn.isEnabled = webView.canGoBack
        forwardButn.isEnabled = webView.canGoForward
    }
}

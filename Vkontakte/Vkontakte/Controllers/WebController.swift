//
//  WebController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/20/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import RealmSwift

class WebController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
            
        }
    }
    
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        componets()
        
        
    }
    
    
    
    private func activityStart() {
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        indicator.color = .red
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func componets() {
        activityStart()
        var componets = URLComponents()
            componets.scheme = "https"
            componets.host = "oauth.vk.com"
            componets.path = "/authorize"
            componets.queryItems = [
                URLQueryItem(name: "client_id", value: "7446449"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "redirect_url", value: "https://oauth.vk.com/blank.html"),
                URLQueryItem(name: "scope", value: "262150,wall,friends,photos,groups,email") ,
                
                URLQueryItem(name: "response_type", value: "token"),
                URLQueryItem(name: "v", value: "5.82")
        
        ]
        
        let request = URLRequest(url: componets.url!)
        webview.load(request)
        
    }
    
}


extension WebController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            indicator.stopAnimating()
            decisionHandler(.allow)
            return
        }
        
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
        }
        
       
        
       guard let token = params["access_token"],
        let userId = params["user_id"],
        
        
        let intUserId = Int(userId)
        
        else {
            
            decisionHandler(.allow)
            return
        }
        
        
        User.shared.id = intUserId
        User.shared.accessToken = token
        performSegue(withIdentifier: "login", sender: nil)
        indicator.stopAnimating()
        decisionHandler(.cancel) 
        
        
    }
    
}

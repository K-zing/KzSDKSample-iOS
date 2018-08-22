//
//  WebViewCtonroller.swift
//  KzSDK-Example
//
//  Created by K-zing on 11/6/2018.
//  Copyright © 2018 K-zing. All rights reserved.
//

import Foundation
import WebKit
import KzSDK_Swift

class WebViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView(frame: view.frame)
        view.addSubview(webView)
        
        let siteId = "siteId"
        let url = URL(string: "http://www.example.com")!
        if !KzWebViewUtil.loadRequest(webView, url: url, siteId: siteId) {
            webView.loadHTMLString("Login is required", baseURL: nil)
        }
    }
}

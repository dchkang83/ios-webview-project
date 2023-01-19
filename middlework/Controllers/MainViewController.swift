//
//  MainViewController.swift
//  Storyboard1
//
//  Created by 강덕준 on 1/10/23.
//

import Foundation
import UIKit
import WebKit

class MainViewController: BaseViewController { //, WKScriptMessageHandler {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewMainWeb: UIView!
    
    var wkWebView:WKWebView?
    var cookiePool: WKProcessPool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "MainViewController"
        
        
        wkWebView = createWKWebView(viewMainWeb!)
        
        
        
        let appInfo = AppInfo.shared
//        let urlString = "\(appDele!.MAIN_URL!)?deviceType=ios&pushToken=\(fcmToken)&versionCode=\(build)"
        let urlString = "\(appInfo.serverUrl)"
        
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            
            Utils.Log("urlString : \(url)")
            
            wkWebView?.load(urlRequest)
        }
    }
    
    
    
    func createWKWebView(_ view: UIView) -> WKWebView {
        cookiePool = WKProcessPool()
        
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let preferences = WKPreferences()
        // window.open 자바스크립트 함수 호출을 자동으로 할 수 있게??
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.javaScriptEnabled = true

        let wkUScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUScript)
        
//        wkUController.add(self, name: "IosBridge")
        
        let wkWebConfig = WKWebViewConfiguration()

        wkWebConfig.allowsInlineMediaPlayback = true
        wkWebConfig.mediaTypesRequiringUserActionForPlayback = []
        wkWebConfig.userContentController = wkUController
        wkWebConfig.processPool = cookiePool!
        wkWebConfig.preferences = preferences
        wkWebConfig.ignoresViewportScaleLimits = true

        let webViewWK = WKWebView(frame: .zero, configuration: wkWebConfig)
        view.addSubview(webViewWK)
        webViewWK.translatesAutoresizingMaskIntoConstraints = false
        webViewWK.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webViewWK.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webViewWK.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webViewWK.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        webViewWK.uiDelegate = self;
//        webViewWK.navigationDelegate = self;
//        webViewWK.scrollView.delegate = self;
        webViewWK.allowsLinkPreview = true

        return webViewWK;
    }
}

// MARK: WKUIDelegate
//extension MainViewController: WKUIDelegate {
//    internal func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        Utils.Log("createWebViewWith : \(navigationAction.request)")
//        if navigationAction.sourceFrame.isMainFrame == false {
//            webView.load(navigationAction.request)
//        }
//
//        return nil;
//    }
//}























































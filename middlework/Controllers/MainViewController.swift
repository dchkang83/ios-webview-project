//
//  MainViewController.swift
//  Storyboard1
//
//  Created by 강덕준 on 1/10/23.
//

import Foundation
import UIKit
import WebKit

class MainViewController: BaseViewController {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewMainWeb: UIView!
    
    var wkWebView:WKWebView?
    var cookiePool: WKProcessPool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "MainViewController"
        
        wkWebView = createWKWebView(viewMainWeb!)
//        viewMainWeb?.addSubview(wkWebView!)
        
        
        /*
        let appInfo = AppInfo.shared
//        let urlString = "\(appDele!.MAIN_URL!)?deviceType=ios&pushToken=\(fcmToken)&versionCode=\(build)"
        let urlString = "\(appInfo.serverUrl)"
        
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            Utils.Log("urlString : \(url)")
            
//            self.wkWebView?.load(urlRequest)
            DispatchQueue.main.async {
                self.wkWebView?.load(urlRequest)
            }
        }
        */
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        isOn = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        isOn = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
        let appInfo = AppInfo.shared
//        let urlString = "\(appDele!.MAIN_URL!)?deviceType=ios&pushToken=\(fcmToken)&versionCode=\(build)"
        let urlString = "\(appInfo.serverUrl)"
        
        
        // TODO. test
        let token: String = "sdsd"
        UserDefaults.standard.set(token, forKey: "fcmToken")
        UserDefaults.standard.synchronize()
        
        if let fcmToken = UserDefaults.standard.object(forKey: "fcmToken") as? String {
            if let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) {
//                let urlString = "\(urlString)?deviceType=ios&pushToken=\(fcmToken)&versionCode=\(build)"
                let urlString = "\(urlString)?deviceType=ios&pushToken=\(fcmToken)&versionCode=2128"
                
//                Utils.Log("urlString 111 : " + urlString);
                
                if let url = URL(string: urlString) {
                    let urlRequest = URLRequest(url: url)
                    
                    
//                    wkWebView?.load(urlRequest)
                    DispatchQueue.main.async {
                        self.wkWebView?.load(urlRequest)
                    }
                }
            }
        } else {
            if let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) {
//                let urlString = "\(urlString)?deviceType=ios&pushToken=&versionCode=\(build)"
                let urlString = "\(urlString)?deviceType=ios&pushToken=&versionCode=2128"
                
                
//                Utils.Log("urlString 222 : " + urlString);
                
                if let url = URL(string: urlString) {
                    let urlRequest = URLRequest(url: url)
                    
//                    wkWebView?.load(urlRequest)
                    DispatchQueue.main.async {
                        self.wkWebView?.load(urlRequest)
                    }
                }
            }
        }
        
        
        
        /*
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            Utils.Log("urlString : \(url)")
            
            wkWebView?.load(urlRequest)
//            self.wkWebView?.load(urlRequest)
//            DispatchQueue.main.async {
//                self.wkWebView?.load(urlRequest)
//            }
        }
         */
    }
}

extension MainViewController {
    private func createWKWebView(_ view: UIView) -> WKWebView {
        cookiePool = WKProcessPool()
        
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let preferences = WKPreferences()
        
        
        // 사용자가 동작하지 않아도 JavaScript를 통해 새 창 열기가 가능한지
        // window.open 자바스크립트 함수 호출을 자동으로 할 수 있게??
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        // 아래 Deprecated 됨 (기본:true - 활성화)
//        preferences.javaScriptEnabled = true

        let userScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let contentController = WKUserContentController()
        contentController.addUserScript(userScript)
        
        // Swift에 JavaScript 인터페이스 연결
        contentController.add(self, name: "IosBridge")
        
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.allowsInlineMediaPlayback = true
        wkWebConfig.mediaTypesRequiringUserActionForPlayback = []
        
        
        // TODO. 이놈이 alert 안되게 하는 원인임..
        // 웹 컨텍스트와 연결할 사용자 Content 컨트롤러
        wkWebConfig.userContentController = contentController
        
        
        // WKProcessPool을 만들어서 WKWebView들에게서 Cookie 공유
        wkWebConfig.processPool = cookiePool!
        wkWebConfig.preferences = preferences
        // WKWebView 객체가 웹페이지의 크기 변경을 항상 허용해야 하는지 결정하는 Bool 값 (기본값 : false)
        wkWebConfig.ignoresViewportScaleLimits = true

        let webViewWK = WKWebView(frame: .zero, configuration: wkWebConfig)
//        let webViewWK = WKWebView(frame: view.frame, configuration: wkWebConfig)
//        let webViewWK = WKWebView(frame: self.view.frame, configuration: wkWebConfig)
        
        view.addSubview(webViewWK)
        webViewWK.translatesAutoresizingMaskIntoConstraints = false
        webViewWK.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webViewWK.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webViewWK.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webViewWK.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // 딜리게이트 설정 (웹뷰에 이벤트 발생시 self가 응답을 해줌)
        webViewWK.uiDelegate = self;
        webViewWK.navigationDelegate = self;
//        webViewWK.scrollView.delegate = self;
        webViewWK.allowsLinkPreview = true
        
//        webViewWK.becomeFirstResponder()
        return webViewWK;
    }
    
    
//    func loadJavascriptForPush(_ userInfo: NSDictionary) {
//        var outterJson:[String:Any] = [:]
//
//        for key in userInfo.allKeys {
//            outterJson[key as! String] = userInfo[key]
//        }
//
//        do {
//            let nsData = try JSONSerialization.data(withJSONObject: outterJson, options: .prettyPrinted)
//            if let nsString = String(data: nsData, encoding: .utf8) {
//                let str = "Common.Native.notification(\(nsString));"
//                Utils.Log("str : \(str)")
//                wkWebView!.evaluateJavaScript(str, completionHandler: { result, error in
//                    if error != nil {
//                        Utils.Log("loadJavascriptForPush evaluateJavaScript error : \(error!.localizedDescription)")
//                    }
//                    if result != nil {
//                        Utils.Log("loadJavascriptForPush evaluateJavaScript result : \(result!)")
//                    }
//                })
//            } else {
//                Utils.Log("let nsString = String(data: nsData, encoding: .utf8) is nil")
//            }
//        } catch {
//            Utils.Log("loadJavascriptForPush error : \(error.localizedDescription)")
//        }
//    }
    
}



// MARK: WKUIDelegate
extension MainViewController: WKUIDelegate {
    // 새로운 웹뷰를 만들어 주는 메소드 (window.open)
    internal func webView(_ webView: WKWebView,
                          createWebViewWith configuration: WKWebViewConfiguration,
                          for navigationAction: WKNavigationAction,
                          windowFeatures: WKWindowFeatures) -> WKWebView? {
        Utils.Log("createWebViewWith : \(navigationAction.request)")
        if navigationAction.sourceFrame.isMainFrame == false {
            webView.load(navigationAction.request)
        }

        return nil;
    }
    
    // Alert
    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        Utils.Log("Alert")
        
        
        let alertController = UIAlertController(title: "test11", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
            completionHandler()
        }
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }

    // Confirm
    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        Utils.Log("Confirm")
        
        let alertController = UIAlertController(title: "test11", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            completionHandler(false)
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler(true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


//extension MainViewController: WKUIDelegate {
//
//    func webView(
//        _ webView: WKWebView,
//        runJavaScriptConfirmPanelWithMessage message: String,
//        initiatedByFrame frame: WKFrameInfo,
//        completionHandler: @escaping (Bool) -> Void
//    ) {
//
//        let alert = UIAlertController(
//            title: nil,
//            message: message,
//            preferredStyle: .alert
//        )
//
//        // Ok button을 누를 때 confirm
//        let okAction = UIAlertAction(
//            title: "OK",
//            style: .default,
//            handler: { action in
//                completionHandler(true)
//            }
//        )
//
//        // Cancel button을 누를 떄 cancel
//        let cancelAction = UIAlertAction(
//            title: "cancel",
//            style: .cancel,
//            handler: { action in
//                completionHandler(false)
//            }
//        )
//
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true, completion: nil)
//    }
//}


// MARK: WKNavigationDelegate
extension MainViewController: WKNavigationDelegate {
    
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Utils.Log("didFinish stop loading : \(webView.url!.absoluteString) ")
        
//        wkWebView?.evaluateJavaScript("alert('Hello from evaluateJavascript()')", completionHandler: nil)
//        wkWebView?.evaluateJavaScript("alert(12345)", completionHandler: nil)
//        if timer404 != nil {
//            timer404!.invalidate()
//            timer404 = nil;
//        }
        
        guard let _ = webView.url!.absoluteString.removingPercentEncoding else {
            return
        }
//        if webView == webViewWKOut {
//            if isGobangURL(webViewWKOut!.url!.absoluteString.removingPercentEncoding!) {
//                if frameWindow!.isHidden == false {
//                    webViewWKWindow!.load(URLRequest(url: webViewWKOut!.url!))
//                }
//                else if viewWebWindow1!.isHidden == false {
//                    webViewWKWindow1!.load(URLRequest(url: webViewWKOut!.url!))
//                }
//                else{
//                    webViewWK!.load(URLRequest(url: webViewWKOut!.url!))
//                }
//                clickBack2(sender: UIButton())
//            }
//        }
//        loadingView?.isHidden = true
    }
}






// WebAction을 구분하는데 사용되는 타입
enum WebAction: String {
    case setAppData
    case getAppData
}
extension MainViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        Utils.Log("userContentController CALLBACK")
        
        
        guard message.name == "IosBridge",
              let messages = message.body as? [String: Any],
              let action = messages["action"] as? String else { return }

        let webAction = WebAction(rawValue: action)
        
        
        
        // TODO. 작업중
//        let name = message.name
//        guard let body = message.body as? [String: Any] else {
//            return
//        }
//        guard let action = body["action"] as? String else {
//            return
//        }
        
        
        switch webAction {
            case .setAppData:
                Utils.Log("setAppData")
            
                guard let params = messages["params"] as? String else {
                    return
                }
                UserDefaults.standard.set(params, forKey: "COOKIE")
                UserDefaults.standard.synchronize()
            
            case .getAppData:
                Utils.Log("getAppData")
            
                guard let params = messages["params"] as? String else {
                    return
                }
            
                let cookie = (UserDefaults.standard.object(forKey: "COOKIE") as? String) ?? ""
                Utils.Log("getAppData params - cookie : \(params) - \(cookie)")
            
            
                wkWebView!.evaluateJavaScript("\(params)('\(cookie)');") { result, error in
    //                webViewWKOut!.evaluateJavaScript("\(params)('\(cookie)');") { result, error in
                    guard error == nil else {
                        return
                    }
                }
            
//                webViewWKOut!.evaluateJavaScript("\(params)('\(cookie)');") {
//                    [self] result, error in
//                    var l_webViewWKOut:WKWebView? = webViewWK;
//                    if viewWebWindow1!.isHidden == false {
//                        l_webViewWKOut = webViewWKWindow1;
//                    }
//                    let cookie = (UserDefaults.standard.object(forKey: "COOKIE") as? String) ?? ""
//                    Utils.Log("1111 getAppData : \(params) - \(cookie)")
//                    l_webViewWKOut!.evaluateJavaScript("\(params)('\(cookie)');") { result, error in
//                        //                webViewWKOut!.evaluateJavaScript("\(params)('\(cookie)');") { result, error in
//                        guard error == nil else {
//                            return
//                        }
//                    }
//                }
            default:
                Utils.Log("undefined action")
        }
        
    }
}


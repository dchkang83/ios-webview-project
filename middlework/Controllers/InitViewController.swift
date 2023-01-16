//
//  InitViewController.swift
//  Storyboard1
//
//  Created by 강덕준 on 1/10/23.
//

import Foundation
import UIKit

class InitViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.red]
//        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .darkGray
//        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]

//        title = "INIT"
        
        print("######### Init ViewController - viewDidLoad")
        
        
        
        
        let appInfo = AppInfo.shared
        print("appInfo.url : \(appInfo.url)")
        
        appInfo.url = "http://localhost"
        print("appInfo.url : \(appInfo.url)")
        
        // Optional Binding
        if let appName = appInfo.name,
            let appScheme = appInfo.scheme,
            let appVersion = appInfo.version {
                print("appName: \(appName)")
                print("appScheme: \(appScheme)")
                print("appVersion: \(appVersion)")
        }
        
    }
}

//
//  BaseViewController.swift
//  Storyboard1
//
//  Created by 강덕준 on 1/12/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("######### [BASE] ViewController - viewDidLoad")
    }
}

extension BaseViewController {
    func showAlert(
        title: String?,
        message: String?,
        confirmHandler: (() -> Void)? = nil,
        completion: (() -> Void)? = nil)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            if let handler = confirmHandler {
                handler()
            }
        }
        alertView.addAction(confirmAction)
        present(alertView, animated: true, completion: completion)
    }
    
//    func showAlert(
//        title: String?,
//        confirmHandler: (() -> Void)? = nil,
//        completion: (() -> Void)? = nil)
//    {
//        let alertView = UIAlertController(title: title, message: "message", preferredStyle: .alert)
//        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
//            if let handler = confirmHandler {
//                handler()
//            }
//        }
//        alertView.addAction(confirmAction)
//        present(alertView, animated: true, completion: completion)
//    }
    
    func goToLoginView() {
        // 로그인 여부 체크 및 이동
    }
}

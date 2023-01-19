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
        let appInfo = AppInfo.shared
        Utils.Log("appInfo.serverUrl : \(appInfo.serverUrl)")

        appInfo.serverUrl = "http://localhost"
        Utils.Log("appInfo.serverUrl : \(appInfo.serverUrl)")

        // Optional Binding
        if let appName = appInfo.name,
           let appScheme = appInfo.scheme,
           let appVersion = appInfo.version {
            Utils.Log("appName: \(appName)")
            Utils.Log("appScheme: \(appScheme)")
            Utils.Log("appVersion: \(appVersion)")
        }
        
        Utils.Log("Utils.isDebug : \(Utils.isDebug())")
        Utils.Log("SERVER : \(Constants.SERVER_PROD)")
        Utils.Log("URL : \(Constants.SERVERS[Constants.SERVER_PROD]!["URL"]!)")
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 메인 컨트롤러로 이동
        let callback = { self.gotoMain() }
        
        if (Utils.isDebug() == true) {
            self.openServerSelectAlert(callback: callback)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // 딜레이 3초 이후 콜백 함수 호출
                callback()
            }
        }
    }
    
    private func openServerSelectAlert(callback: @escaping() -> Void) {
        let alerts = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alerts.addAction(getAlertAction(serverMode: Constants.SERVER_LOCAL, callback: { callback() }))
        alerts.addAction(getAlertAction(serverMode: Constants.SERVER_DEV, callback: { callback() }))
        alerts.addAction(getAlertAction(serverMode: Constants.SERVER_STG, callback: { callback() }))
        alerts.addAction(getAlertAction(serverMode: Constants.SERVER_PROD, callback: { callback() }))
        alerts.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: { _ in callback() }))
        self.present(alerts, animated: true)
    }
    
    private func getAlertAction(serverMode: String, callback: (() -> Void)? = nil) -> UIAlertAction {
        let title = Constants.SERVERS[serverMode]!["NAME"]!
        
        return UIAlertAction(title: title, style: .default, handler: { _ in
            // 서버 정보 설정
            self.setAppInfo(serverMode: serverMode)
            
            // 콜백
            callback?()
        })
    }
    
    private func setAppInfo(serverMode: String) -> Void {
        let appInfo = AppInfo.shared
        
        appInfo.serverMode = serverMode
        appInfo.serverName = Constants.SERVERS[serverMode]!["NAME"]!
        appInfo.serverUrl = Constants.SERVERS[serverMode]!["URL"]!
    }
    
    private func gotoMain() {
        let appInfo = AppInfo.shared
        Utils.Log("############### gotoMain appInfo.serverUrl : \(appInfo.serverUrl)")
        
        // ##### CASE1. ViewController의 view 바꿔치기
//        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC")
//
//        self.navigationController?.viewControllers[0] = mainVC
        
        // ##### CASE2. ViewController가 다른 ViewController를 호출(present)
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
        mainVC?.modalPresentationStyle = .fullScreen // 전체화면으로 보이게 설정
        mainVC?.modalTransitionStyle = .crossDissolve // 전환 애니메이션 설정

        self.present(mainVC!, animated: true, completion: nil)
        
        
        // 화면 전환 애니메이션 설정
//        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVC")
//        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
//        mainVC.modalPresentationStyle = .fullScreen
//        mainVC.modalTransitionStyle = .coverVertical
//
//        self.present(mainVC, animated: true, completion: nil)
        
        // ##### CASE3. NavigationViewController 사용하여 화면 전환(push)
//        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
//
//        // Push View Controller Onto Navigation Stack
//        self.navigationController?.pushViewController(mainVC!, animated: true)
//
//        // Pop View Controller From Navigation Stack
//        self.navigationController?.popViewController(animated: true)
//
//        // 제스처로 뒤로가는 기능 삭제
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//
//        // 네비게이션 바 안보이게 (커스텀 할 경우 RootView에 한번 만들어주면 다 없어짐)
//        self.navigationController?.navigationBar.isHidden = true
        
    }
}

//
//  AppInfo.swift
//  Storyboard1
//
//  Created by 강덕준 on 1/13/23.
//

import Foundation

class AppInfo {
    static let shared = AppInfo() // static을 이용해 Instance를 저장할 프로퍼티를 하나 생성
    private init() {}
 
    var mainInfo: [String : Any]? {
        guard let info = Bundle.main.infoDictionary else {
            return nil
        }
        return info
    }
 
    var name: String? {
        self.mainInfo?["CFBundleName"] as? String
    }
 
    var scheme: String? {
        guard let urlTypes = self.mainInfo?["CFBundleURLTypes"] as? [AnyObject],
            let urlTypeDictionary = urlTypes.first as? [String: AnyObject],
            let urlSchemes = urlTypeDictionary["CFBundleURLSchemes"] as? [AnyObject],
            let scheme = urlSchemes.first as? String else { return nil }
        return scheme
    }
 
    var version: String? {
        self.mainInfo?["CFBundleShortVersionString"] as? String
    }
    
    // 웹뷰 서버 정보
    var serverMode = Constants.SERVER_PROD
    var serverName = Constants.SERVERS[Constants.SERVER_PROD]!["NAME"]!
    var serverUrl: String = "https://www.google.com"
}

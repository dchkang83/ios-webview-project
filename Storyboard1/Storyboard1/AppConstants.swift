//
//  Constants.swift
//  Storyboard1
//
//  Created by 강덕준 on 1/19/23.
//

import Foundation

extension Constants {
    static let SERVERS = [
        SERVER_LOCAL: [
            "NAME": "로컬",
            "URL": "http://localhost:9002/app/init"
        ],
        SERVER_DEV: [
            "NAME": "개발",
            "URL": "https://gobang.d-neoflat.net/app/init"
        ],
        SERVER_STG: [
            "NAME": "스테이징",
            "URL": "https://gobang.t-neoflat.net/app/init"
        ],
        SERVER_PROD: [
            "NAME": "운영",
            "URL": "https://m.gobang.kr/app/init"
        ]
    ]
}

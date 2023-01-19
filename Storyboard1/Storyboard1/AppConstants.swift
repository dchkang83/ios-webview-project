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
            "URL": "http://local"
        ],
        SERVER_DEV: [
            "NAME": "개발",
            "URL": "https://dev"
        ],
        SERVER_STG: [
            "NAME": "스테이징",
            "URL": "https://staging"
        ],
        SERVER_PROD: [
            "NAME": "운영",
            "URL": "https://production"
        ]
    ]
}

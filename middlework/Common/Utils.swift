//
//  Utils.swift
//  Storyboard1
//
//  Created by 강덕준 on 1/16/23.
//

import Foundation

class Utils {
    public static func isDebug() -> Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    public static func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcName: String = #function) {
        #if DEBUG
        // Optional Binding
//        if let obj = object {
//            print("\(Date()) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) : \(obj)")
//        } else {
//            print("\(Date()) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) : nil")
//        }
        if let obj = object {
            print("\(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) : \(obj)")
        } else {
            print("\(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) : nil")
        }
        #endif
    }
}

//
//  NSDate-Extension.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String {
        return "\(NSDate().timeIntervalSince1970)"//interval
    }
}

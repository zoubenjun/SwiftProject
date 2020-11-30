//
//  BaseModel.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import Foundation

class BaseModel: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""

    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

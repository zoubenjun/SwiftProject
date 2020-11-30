//
//  AnchorModel.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import Foundation

class AnchorModel: NSObject {
    var room_id: Int = 0
    var vertical_src: String = ""
    var isVertical: Int = 0
    var room_name: String = ""
    var nickname: String = ""
    var online: Int = 0
    var anchor_city: String = ""
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    
    }
}

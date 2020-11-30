//
//  CycleModel.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import Foundation

class CycleModel: NSObject {
    var title: String = ""
    var pic_url: String = ""
    var anchor: AnchorModel?
    var room: [String: Any]?{
        didSet{
            guard let room = room  else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

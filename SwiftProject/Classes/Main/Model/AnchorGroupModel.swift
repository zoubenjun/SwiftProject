//
//  AnchorGroupModel.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import Foundation

class AnchorGroupModel: BaseModel {
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    var icon_name: String = "home_header_normal"
    var room_list: [[String: Any]]? {
        didSet {
            guard let room_list2 = room_list else { return }
            for dict in room_list2 {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
}

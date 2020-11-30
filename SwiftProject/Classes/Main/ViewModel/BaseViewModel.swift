//
//  BaseViewModel.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import Foundation

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        HttpTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            guard let dict = result as? [String : Any] else { return }
            guard let arr = dict["data"] as? [[String : Any]] else { return }
            if isGroupData {
                for dict in arr {
                    self.anchorGroups.append(AnchorGroupModel(dict: dict))
                }
            } else  {
                let group = AnchorGroupModel()
                for dict in arr {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            finishedCallback()
        }
    }
}

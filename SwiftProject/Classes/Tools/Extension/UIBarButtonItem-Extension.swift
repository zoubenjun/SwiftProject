//
//  UIBarButtonItem.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/27.
//

import UIKit

internal extension UIBarButtonItem {
    convenience init(imageName: String, highlightedImage: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if (highlightedImage != "") {
            btn.setImage(UIImage(named: highlightedImage), for: .highlighted)
        }
        if (size != CGSize.zero) {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        } else {
            btn.sizeToFit()
        }
        self.init(customView: btn)
    }
}

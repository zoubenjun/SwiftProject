//
//  ViewController.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/24.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyBoardName: "Home")
        addChildVC(storyBoardName: "Live")
        addChildVC(storyBoardName: "Follow")
        addChildVC(storyBoardName: "Profile")
    }

    fileprivate func addChildVC(storyBoardName: String) {
        
        let childVC = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        addChild(childVC)
    }
}


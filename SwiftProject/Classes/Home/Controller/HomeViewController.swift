//
//  HomeViewController.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/24.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    let titles = ["推荐","手游","娱乐","游戏","趣玩"]
    
    fileprivate lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: UIApplication.statusBarHeight + kNavBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: (self?.titles)!)
        
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: UIApplication.statusBarHeight + kNavBarH + kTitleViewH, width: kScreenW, height: kScreenH - UIApplication.statusBarHeight - kNavBarH - kTitleViewH - kTabBarH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
//        childVcs.append(HandsVC())
//        childVcs.append(AmuseVC())
//        childVcs.append(GameVC())
//        childVcs.append(FunnyVC())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        //MARK:- 控制器作为PageContentViewDelegate代理
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

internal extension HomeViewController {
    private func setupUI() {
        
        setupNavigationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItems = [UIBarButtonItem(imageName: "logo")]
        let size = CGSize(width: 30, height: 40)
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highlightedImage: "searchBtnIconHL", size: size)
        let qrItem = UIBarButtonItem(imageName: "scanIcon", highlightedImage: "scanIconHL", size: size)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highlightedImage: "viewHistoryIconHL", size: size)
        let messageItem = UIBarButtonItem(imageName: "siteMessageHome", highlightedImage: "siteMessageHomeHL", size: size)
        navigationItem.rightBarButtonItems = [searchItem, qrItem, historyItem, messageItem]
    }
}

extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

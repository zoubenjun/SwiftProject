//
//  RecommendViewController.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/30.
//

import UIKit

private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    fileprivate lazy var recommendViewModel: RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        //在collection上添加额外的视图用-
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)//指定大小
        return cycleView
    }()
    
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        //边距是两个额外的视图
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
    }

    override func loadData() {
        baseVM = recommendViewModel
        //闭包对VC有强引用  VC对RecommendViewModel有强引用 RecommendViewModel没有对闭包有强引用 =>没有形成循环引用
        recommendViewModel.requestData {
            self.collectionView.reloadData()
            //二次处理
            var gameGroups = self.recommendViewModel.anchorGroups
            gameGroups.removeFirst()
            gameGroups.removeFirst()
            gameGroups.remove(at: 1)
            let moreGroup = AnchorGroupModel()
            moreGroup.tag_name = "更多"
            gameGroups.append(moreGroup)
            self.gameView.groups = gameGroups
            self.loadDataFinished()
        }
        recommendViewModel.requestCycleData {
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
//        self.loadDataFinished()
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = recommendViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else{
            //            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CollectionNormalCell
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}

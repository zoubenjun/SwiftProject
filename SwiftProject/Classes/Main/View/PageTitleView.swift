//
//  PageTitleView.swift
//  SwiftProject
//
//  Created by zoubenjun on 2020/11/27.
//

import UIKit

internal protocol PageTitleViewDelegate: class {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}

private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let kScrollLineH: CGFloat = 4
private let lineH: CGFloat = 0.5

class PageTitleView: UIView {
    weak var delegate: PageTitleViewDelegate?
    
    fileprivate var currentLabelIndex: Int = 0
    fileprivate var titles: [String]
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return scrollLine
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal extension PageTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        setupBottomAndLine()
    }
    
    fileprivate func setupTitleLabels() {
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomAndLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        guard let firstLabel = titleLabels.first else { return  }
        firstLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x + firstLabel.frame.width * 0.1, y: frame.height - kScrollLineH, width: firstLabel.frame.width * 0.8, height: kScrollLineH)
    }
}

internal extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        guard let currentLabel = tapGes.view as? UILabel else { return }
        if (currentLabel.tag == currentLabelIndex) {
            return
        }
        let oldLabel = titleLabels[currentLabelIndex]
        currentLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        oldLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        currentLabelIndex = currentLabel.tag
        let scrollLinePosition = currentLabel.frame.origin.x + currentLabel.frame.width * 0.1
        scrollLine.frame.size.width = currentLabel.frame.width * 0.8
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        delegate?.pageTitleView(self, selectedIndex: currentLabelIndex)
    }
}

extension PageTitleView {
    func setTitleWithProgress(_ progress:CGFloat,sourceIndex : Int,targetIndex : Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + sourceLabel.frame.width*0.1 + moveX
        
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        currentLabelIndex = targetIndex
    }
}

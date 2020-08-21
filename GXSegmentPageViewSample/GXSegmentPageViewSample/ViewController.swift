//
//  ViewController.swift
//  GXSegmentPageViewSample
//
//  Created by Gin on 2020/8/18.
//  Copyright © 2020 gin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var pageView: GXSegmentPageView = {
        var children: [UIViewController] = []
        for i in 0..<9 {
            let vc: OneViewController = OneViewController(number: i)
            children.append(vc)
        }
        var frame = self.view.bounds
        frame.origin.y = 60
        frame.size.height = self.view.bounds.height - 60
        return GXSegmentPageView(frame: frame, parent: self, children: children)
    }()

    private lazy var segmentView: GXSegmentTitleView = {
        var frame = self.view.bounds
        frame.origin.y = 20
        frame.size.height = 40
        let titles: [String] = ["新闻", "推荐的", "实时资讯", "新闻", "推荐的", "实时资讯", "新闻", "推荐的", "实时资讯"]
        var config = GXSegmentTitleView.Configuration()
        config.style = .bottom
        config.indicatorStyle = .dynamic
        config.indicatorFixedWidth = 30.0
        config.indicatorFixedHeight = 2.0
        config.indicatorAdditionWidthMargin = 5.0
        config.indicatorAdditionHeightMargin = 2.0
        config.isShowSeparator = true
        config.separatorInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        var view = GXSegmentTitleView(frame: frame, config: config, titles: titles)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segmentView.delegate = self
        self.pageView.delegate = self
        self.view.addSubview(self.pageView)
        self.view.addSubview(segmentView)
    }
}

extension ViewController: GXSegmentPageViewDelegate {
    func segmentPageView(_ segmentPageView: GXSegmentPageView, at index: Int) {
        NSLog("at index = %d", index)
    }
    func segmentPageView(_ page: GXSegmentPageView, progress: CGFloat) {
        NSLog("currentIndex = %d, willIndex = %d, progress = %f", page.selectIndex, page.willSelectIndex, progress)
        self.segmentView.setSegmentTitleView(currentIndex: page.selectIndex, willIndex: page.willSelectIndex, progress: progress)
    }
}

extension ViewController: GXSegmentTitleViewDelegate {
    func segmentTitleView(_ page: GXSegmentTitleView, at index: Int) {
        self.pageView.scrollToItem(to: index, animated: true)
    }
}

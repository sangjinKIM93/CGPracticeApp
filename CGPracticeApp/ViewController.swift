//
//  ViewController.swift
//  CGPracticeApp
//
//  Created by 김상진 on 2022/05/09.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let customView: CustomView = {
        let view = CustomView()
        return view
    }()
    
    var scrollingViewLayer: CAScrollLayer {
        return customView.layer as! CAScrollLayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollingViewLayer.scrollMode = .vertically
        setupView()
        setPanGesture()
    }

    private func setupView() {
        self.view.addSubview(customView)
        
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setPanGesture() {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePangesture(_:)))
        self.customView.addGestureRecognizer(recognizer)
    }
    
    var flag: Int = 2
    
    @objc func handlePangesture(_ sender: UIPanGestureRecognizer) {
        var newPoint = customView.bounds.origin
        newPoint.y -= sender.translation(in: customView).y
        sender.setTranslation(CGPoint.zero, in: customView)
        scrollingViewLayer.scroll(to: newPoint)
        
        guard newPoint.y > 0 else { return }

        let velocity = sender.velocity(in: customView)
        let height = CGFloat(view.frame.height / 4)

        let newFlag = Int(newPoint.y / height)
        if newFlag != flag {
            flag = newFlag

            if velocity.y < 0 {
                // 아래로 스크롤(down)
                print("down")
                print(newFlag)
                customView.addImageLayerByNumber(number: newFlag + 5, rect: self.view.frame)
                customView.removeImageLayerByNumber(number: newFlag)
            } else {
                // 위로 스크롤(up)
                print("up")
                print(newFlag)
                customView.addImageLayerByNumber(number: newFlag + 1, rect: self.view.frame)
                customView.removeImageLayerByNumber(number: newFlag + 6)
            }
        }
    }
}


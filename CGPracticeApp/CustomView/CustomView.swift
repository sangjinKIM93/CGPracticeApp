//
//  CustomView.swift
//  CGPracticeApp
//
//  Created by 김상진 on 2022/05/09.
//

import UIKit

class CustomView: UIView {

    var layerArray: [CALayer] = []
    
    override class var layerClass: AnyClass {
        return CAScrollLayer.self
    }
    
    override func draw(_ rect: CGRect) {
        
        for index in 1...5 {
            let layer = CALayer()
            layerArray.append(layer)
            addImageLayer(layer: layer, rect: rect, number: index)
        }

        // 50개 이미지 전부 로드
//        var imageRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height / 4)
//        for index in 1...50 {
//
//            if let image = UIImage(named: "sample_images_\(index)") {
//                addImageLayer(image: image, rect: imageRect, name: "\(index)")
//            }
//            imageRect.origin.y += imageRect.height
//        }
    }
    
    private func addImageLayer(layer: CALayer, rect: CGRect, number: Int) {
        let y = Int(rect.height) / 4 * (number - 1)
        let imageRect = CGRect(x: 0, y: CGFloat(y), width: rect.width, height: rect.height / 4)
        
        layer.frame = imageRect
        layer.name = "\(number)"
        layer.contents = UIImage(named: "sample_images_\(number)")?.cgImage
        layer.contentsGravity = .resizeAspectFill
        layer.cornerRadius = 10
        layer.borderWidth = 5
        layer.borderColor = UIColor.yellow.cgColor
        layer.masksToBounds = true
        self.layer.addSublayer(layer)
    }
    
    func addImageLayerByNumber(number: Int, rect: CGRect, isTop: Bool) {
        if isTop {
            if let layer = layerArray.popLast() {
                addImageLayer(layer: layer, rect: rect, number: number)
                layerArray.insert(layer, at: 0)
            }
        } else {
            guard !layerArray.isEmpty else {
                return
            }
            let layer = layerArray.removeFirst()
            addImageLayer(layer: layer, rect: rect, number: number)
            layerArray.append(layer)
        }
    }
    
    func removeImageLayerByNumber(number: Int) {
        layer.sublayers?
            .first(where: { $0.name == "\(number)"})?
            .removeFromSuperlayer()
    }
}

//
//  AddButton.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

class AddButton: UIButton {
    
    private var hasSet = false
    
    override var bounds: CGRect {
        didSet {
            if oldValue != bounds {
                hasSet = false
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !hasSet {
            self.backgroundColor = self.gradientColor(from: self.bounds)
            hasSet = true
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    private func gradientColor(from frame: CGRect) -> UIColor? {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.colors = [UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0).cgColor, UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        
        guard let img = UIImage.getImage(from: layer) else {
            return nil
        }
        
        return UIColor(patternImage: img)
    }

}

extension UIImage {
    class func getImage(from layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

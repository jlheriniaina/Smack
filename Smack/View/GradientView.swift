//
//  GradientView.swift
//  Smack
//
//  Created by lucas on 13/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor : UIColor = #colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var bottomColor : UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    override func layoutSubviews() {
        let gardientLayer = CAGradientLayer()
        gardientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gardientLayer.startPoint = CGPoint(x: 0, y: 0)
        gardientLayer.endPoint = CGPoint(x: 1, y: 1)
        gardientLayer.frame = self.bounds
        self.layer.insertSublayer(gardientLayer, at: 0)
    }
}

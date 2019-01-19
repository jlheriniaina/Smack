//
//  RoundedButton.swift
//  Smack
//
//  Created by lucas on 13/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var conerRaduis : CGFloat = 0.3 {
        didSet{
            self.layer.cornerRadius = conerRaduis
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView() {
        self.layer.cornerRadius = conerRaduis
    }
    

}

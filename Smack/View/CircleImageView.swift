//
//  CircleImageView.swift
//  Smack
//
//  Created by lucas on 16/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        setupView()
    }
}

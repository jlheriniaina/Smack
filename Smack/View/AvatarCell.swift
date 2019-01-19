//
//  AvatarCell.swift
//  Smack
//
//  Created by lucas on 16/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageViw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initView()
    }
    func initView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    func configureCell(index : Int, type : AvatarType)  {
        if type == AvatarType.dark {
            self.avatarImageViw.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }else {
            self.avatarImageViw.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }
    
}

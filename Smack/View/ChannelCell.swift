//
//  ChannelCell.swift
//  Smack
//
//  Created by lucas on 18/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else {
               self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    func configureCell(chanel: Channel) {
        self.nameLbl.text = "#\(chanel.getName() ?? "")"
    }
}

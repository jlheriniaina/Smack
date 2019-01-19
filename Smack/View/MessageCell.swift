//
//  MessageCell.swift
//  Smack
//
//  Created by lucas on 19/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var avatarMessage: CircleImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var msgLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(message: Message) {
        self.avatarMessage.image = UIImage(named: message.getUserAvatar())
        self.avatarMessage.backgroundColor = Utils.colorImage(color: message.getUserColorAvatar())
        self.userNameLbl.text = message.getUsername()
        self.msgLbl.text = message.getContent()
    }

}

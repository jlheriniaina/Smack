//
//  ChannelVC.swift
//  Smack
//
//  Created by lucas on 13/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 40
    }

    @IBAction func onClckLogin(_ sender: Any) {
        performSegue(withIdentifier: LOGIN_VC, sender: nil)
    }
}

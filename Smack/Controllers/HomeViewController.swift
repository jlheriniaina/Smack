//
//  ViewController.swift
//  Smack
//
//  Created by lucas on 05/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var btnMenu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if UserSessionManager.instance.getIslogin() {
            UserService.instance.getUserByEmail(completion: { (succes) in
                NotificationCenter.default.post(name: NOTIF_DATA_USER, object: nil)
            })
        }
    }
   
    
}


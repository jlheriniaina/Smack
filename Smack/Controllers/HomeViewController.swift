//
//  ViewController.swift
//  Smack
//
//  Created by lucas on 05/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        NotificationCenter.default.addObserver(self, selector: #selector(userData(_:)), name: NOTIF_DATA_USER, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIF_LOAD_SELECTED, object: nil)
        if UserSessionManager.instance.getIslogin() {
            UserService.instance.getUserByEmail(completion: { (succes) in
                NotificationCenter.default.post(name: NOTIF_DATA_USER, object: nil)
            })
        }
    }
    @objc func userData(_ notif: Notification){
        if UserSessionManager.instance.getIslogin(){
            self.onLoginGetMessage()
        }else {
            titleLbl.text = "Please Log In"
        }
    }
    func onLoginGetMessage() {
        MessageService.instance.allChannel { (succes, listChannel) in
            if succes {
                
            }
        }
    }
   @objc func channelSelected(_ notif: Notification) {
       updateWith()
    }
    func updateWith()  {
        let channelName = MessageService.instance.channel.getName()
        titleLbl.text = "#\(channelName)"
    }
}


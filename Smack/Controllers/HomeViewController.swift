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
    @IBOutlet weak var messageTxtField: UITextField!
    private var newchannel: Channel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bindToKeyboard()
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        
    }
    @objc func userData(_ notif: Notification){
        if UserSessionManager.instance.getIslogin(){
            self.onLoginGetMessage()
        }else {
            titleLbl.text = "Veillez-vous connecter"
        }
    }
   @objc func hidekeyboard() {
       self.view.endEditing(true)
    }
    func onLoginGetMessage() {
        MessageService.instance.allChannel { (succes, listChannel) in
            if succes {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.channel = MessageService.instance.channels[0]
                    self.updateWith()
                }else {
                    self.titleLbl.text = "Aucun chaine de discussion"
                }
            }
        }
    }
   @objc func channelSelected(_ notif: Notification) {
       updateWith()
    }
    func updateWith()  {
        let channel = MessageService.instance.channel
        if channel != nil {
              self.newchannel = channel
              titleLbl.text = "#\(channel!.getName())"
               self.getAllMessage(id: channel!.getId())
        }
    }
    func getAllMessage(id : String) {
        MessageService.instance.allMessage(id: id) { (succes, listMessage) in
            if succes {
                print(listMessage.count)
            }
        }
    }
    
    @IBAction func onClickSendMessage(_ sender: Any) {
        self.view.endEditing(true)
        guard let msg = messageTxtField.text, messageTxtField.text != nil else { return }
        if UserSessionManager.instance.getIslogin() {
            let user = UserSessionManager.instance.getIsLoginUser()
            let userId = user["id"] as! String
            let nom = user["name"] as! String
            let avatarName = user["avatarName"] as! String
            let avatarColor = user["avatarColor"] as! String
            let message = Message(content: msg, idUser: userId, idChannel: self.newchannel.getId(), name: nom, avatar: avatarName, color: avatarColor)
            SocketService.instance.sendMesage(message: message, completion: { (succes) in
                if succes {
                    self.messageTxtField.text = ""
                    self.messageTxtField.resignFirstResponder()
                }
            })
        }
    }
}


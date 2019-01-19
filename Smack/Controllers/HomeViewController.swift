//
//  ViewController.swift
//  Smack
//
//  Created by lucas on 05/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var messageTxtField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSendMessage: UIButton!
    @IBOutlet weak var tapingLbl: UILabel!
    private var newchannel: Channel!
    private var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bindToKeyboard()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        btnSendMessage.isHidden = true
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
        
        SocketService.instance.doListenTapingMessage { (typingUsers) in
            guard let channelId = MessageService.instance.channel?.getId() else { return }
            let user = UserSessionManager.instance.getIsLoginUser()
            var names = ""
            var numberOfTypers = 0
            for (key, value) in typingUsers {
                if key != user["name"] as! String && value == channelId {
                    if names == "" {
                        names = key
                    }else {
                        names = "\(names), \(key)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && UserSessionManager.instance.getIslogin() == true {
                var verb = "est"
                if numberOfTypers > 1 {
                    verb = "sont"
                }
                self.tapingLbl.text = "\(names) \(verb) en train de taper un message."
             }else {
                self.tapingLbl.text = ""
            }
            
        }
        SocketService.instance.getMessage { (succes) in
            if succes {
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: UITableViewScrollPosition.bottom, animated: false)
                    
                }
            }
        }
        
    }
    @objc func userData(_ notif: Notification){
        if UserSessionManager.instance.getIslogin(){
            self.onLoginGetMessage()
        }else {
            titleLbl.text = "Veillez-vous connecter"
            self.tableView.reloadData()
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
                self.tableView.reloadData()
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            cell.configureCell(message: MessageService.instance.messages[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    @IBAction func endDidChange(_ sender: Any) {
        guard let channelId = MessageService.instance.channel?.getId() else {
            return
        }
        let user = UserSessionManager.instance.getIsLoginUser()
        
        if messageTxtField.text == "" {
            isTyping = false
            btnSendMessage.isHidden = true
            SocketService.instance.socket.emit("stopType", user["name"] as! String, channelId)
        }else {
            if isTyping == false {
                self.btnSendMessage.isHidden = false
                SocketService.instance.socket.emit("startType", user["name"] as! String, channelId)
            }
            isTyping = true
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
                    SocketService.instance.socket.emit("stopType", nom,self.newchannel.getId())
                }
            })
        }
    }
}


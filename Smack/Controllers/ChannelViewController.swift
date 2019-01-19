//
//  ChannelVC.swift
//  Smack
//
//  Created by lucas on 13/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avatarImageView: CircleImageView!
    private var channels = [Channel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 40
        NotificationCenter.default.addObserver(self, selector: #selector(userData(_:)), name: NOTIF_DATA_USER, object: nil)
        if UserSessionManager.instance.getIslogin() {
            MessageService.instance.allChannel { (succes, listChannel) in
                if succes && !listChannel.isEmpty {
                    self.channels = listChannel
                    self.tableView.reloadData()
                }
            }
        }
        SocketService.instance.getChannel { (succes, channel) in
            if succes {
                self.channels.append(channel)
            }
            self.tableView.reloadData()
        }
       
    }
    
    @IBAction func onClickShowVC(_ sender: Any) {
        let newChannelVC = NChannelViewController()
        newChannelVC.modalPresentationStyle = .custom
        present(newChannelVC, animated: true, completion: nil)
    }
    
    @IBAction func onClckLogin(_ sender: Any) {
        if UserSessionManager.instance.getIslogin() {
            let profilVC = ProfilViewController()
            profilVC.modalPresentationStyle = .custom
            present(profilVC, animated: true, completion: nil)
            
        }else {
             performSegue(withIdentifier: LOGIN_VC, sender: nil)
        }
       
    }
    @IBAction func prerformeUnwind(sender : UIStoryboardSegue){}
    override func viewDidAppear(_ animated: Bool) {
        SocketService.instance.establishConnection()
        self.userInfo()
    }
    @objc func userData(_ notif: Notification){
          self.userInfo()
    }
    func userInfo() {
        if UserSessionManager.instance.getIslogin() {
            let user = UserSessionManager.instance.getIsLoginUser()
            btnLogin.setTitle(user["name"] as! String, for: .normal)
            avatarImageView.image = UIImage(named: user["avatarName"] as! String)
            avatarImageView.backgroundColor = colorImage(color: user["avatarColor"] as! String)
            
        }else {
            btnLogin.setTitle("Login", for: UIControlState.normal)
            avatarImageView.image = #imageLiteral(resourceName: "menuProfileIcon")
        }
    }
    func colorImage(color : String) -> UIColor {
        let scanner = Scanner(string: color)
        let spiked = CharacterSet(charactersIn: "[], ")
        let sp = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = spiked
        var r,g, b, a : NSString?
        scanner.scanUpToCharacters(from: sp, into: &r)
        scanner.scanUpToCharacters(from: sp, into: &g)
        scanner.scanUpToCharacters(from: sp, into: &b)
        scanner.scanUpToCharacters(from: sp, into: &a)
        let defaultColor = UIColor.lightGray
        guard let rRed = r else {return defaultColor}
        guard let rGreen = g else {return defaultColor}
        guard let rBleu = b else {return defaultColor}
        guard let rAlpha = a else {return defaultColor}
        let rFloat = CGFloat(rRed.doubleValue)
        let gFloat = CGFloat(rGreen.doubleValue)
        let bFloat = CGFloat(rBleu.doubleValue)
        let aFloat = CGFloat(rAlpha.doubleValue)
        return UIColor(red: rFloat, green: bFloat, blue: gFloat, alpha: aFloat)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            cell.configureCell(chanel: channels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

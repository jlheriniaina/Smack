//
//  ProfilViewController.swift
//  Smack
//
//  Created by lucas on 17/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profilImageView: CircleImageView!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initView()
    }
    func initView() {
        let dict = UserSessionManager.instance.getIsLoginUser()
        usernameLbl.text = dict["name"] as! String
        emailLbl.text = dict["email"] as! String
        profilImageView.image = UIImage(named: dict["avatarName"] as! String)
        profilImageView.backgroundColor = Utils.colorImage(color: dict["avatarColor"] as! String)
        
    }
    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickLogout(_ sender: Any) {
        UserSessionManager.instance.logout()
         NotificationCenter.default.post(name: NOTIF_DATA_USER, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}

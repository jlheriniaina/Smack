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
        profilImageView.backgroundColor = colorImage(color: dict["avatarColor"] as! String)
        
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
        return UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
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

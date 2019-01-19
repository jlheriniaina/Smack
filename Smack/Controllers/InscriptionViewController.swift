//
//  InscriptionViewController.swift
//  Smack
//
//  Created by lucas on 13/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class InscriptionViewController: UIViewController {
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var avatarImageView: CircleImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserSessionManager.instance.getAvatar() != nil {
            avatarName = UserSessionManager.instance.getAvatar()!
            avatarImageView.image = UIImage(named: UserSessionManager.instance.getAvatar()!)
            if UserSessionManager.instance.getAvatar()!.contains("ligth") && bgColor != nil {
                avatarImageView.backgroundColor = UIColor.lightGray
            }
        }
       
    }

    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickChoseAvatar(_ sender: Any) {
        self.performSegue(withIdentifier: "avatarVC", sender: nil)
    }
    
    @IBAction func onClickPickBgColor(_ sender: Any) {
         let red = CGFloat(arc4random_uniform(255)) / 255
         let bleu = CGFloat(arc4random_uniform(255)) / 255
         let gren = CGFloat(arc4random_uniform(255)) / 255
         bgColor = UIColor(red: red, green: gren, blue: bleu, alpha: 1)
         avatarColor = "[\(red),\(gren),\(bleu), 1]"
        
         UIView.animate(withDuration: 0.2) {
             self.avatarImageView.backgroundColor = self.bgColor
         }
    
    }
    @IBAction func onClickResister(_ sender: Any) {
        loadingView.isHidden = false
        loadingView.startAnimating()
        guard let name = usernameTxtField.text, usernameTxtField.text != nil else { return }
        guard let email = emailTxtField.text, emailTxtField.text != nil else { return }
        guard let password = passwordTxtField.text, passwordTxtField.text != nil else { return }
        UserService.instance.registerUser(email: email, password: password) { (handler) in
            if handler {
                UserService.instance.loginUser(email: email, password: password, completion: { (succed) in
                    if succed {
                        let user = User(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor)
                        UserService.instance.createUser(user: user, completion: { (isSuccess) in
                            if isSuccess {
                               self.loadingView.isHidden = true
                               self.loadingView.stopAnimating()
                               self.performSegue(withIdentifier: "unWindChanel", sender: self)
                               NotificationCenter.default.post(name: NOTIF_DATA_USER, object: nil)
                            }
                        })
                     
                    }
                })
              
            }
        }
    }
    func initView() {
        loadingView.isHidden = true
        usernameTxtField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [ .foregroundColor : #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)])
        emailTxtField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [ .foregroundColor : #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)])
        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [ .foregroundColor : #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)])
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
    }
   @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}

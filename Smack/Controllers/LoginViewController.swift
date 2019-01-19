//
//  LoginViewController.swift
//  Smack
//
//  Created by lucas on 13/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        UserSessionManager.instance.setAvatar(avatar: "profileDefault")
    }
    override func viewDidAppear(_ animated: Bool) {
         UserSessionManager.instance.setAvatar(avatar: "profileDefault")
        super.viewDidAppear(animated)
    }
    func initView() {
        loadingView.isHidden = true
        usernameTxtField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [ .foregroundColor : #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)])
        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [ .foregroundColor : #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)])
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickCreateAccount(_ sender: Any) {
        performSegue(withIdentifier: CREATE_ACCOUNT, sender: nil)
       
    }
    @IBAction func onClickLogin(_ sender: Any) {
        loadingView.isHidden = false
        loadingView.startAnimating()
        self.view.endEditing(true)
        guard let email = usernameTxtField.text, usernameTxtField.text != "" else { return }
        guard let password = passwordTxtField.text, passwordTxtField.text != "" else { return }
        UserService.instance.loginUser(email: email, password: password) { (success) in
            if success {
               UserService.instance.getUserByEmail(completion: { (succes) in
                    if succes {
                        NotificationCenter.default.post(name: NOTIF_DATA_USER, object: nil)
                        self.loadingView.isHidden = true
                        self.loadingView.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
}

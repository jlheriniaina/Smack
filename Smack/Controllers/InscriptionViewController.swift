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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickChoseAvatar(_ sender: Any) {
    }
    
    @IBAction func onClickPickBgColor(_ sender: Any) {
    }
    @IBAction func onClickResister(_ sender: Any) {
        guard let email = emailTxtField.text, emailTxtField.text != nil else { return }
        guard let password = passwordTxtField.text, passwordTxtField.text != nil else { return }
        AuthService.instance.registerUser(email: email, password: password) { (handler) in
            if handler {
                print("Register succefull")
            }
        }
    }
    
}

//
//  NChannelViewController.swift
//  Smack
//
//  Created by lucas on 18/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class NChannelViewController: UIViewController {
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var descTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        guard let nom = nameLbl.text, nameLbl.text != nil else { return }
        guard let desciption = descTxtField.text, descTxtField.text != nil else { return }
        SocketService.instance.createChannel(name: nom, desc: desciption) { (succes) in
            if succes {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func initView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        nameLbl.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [ .foregroundColor : #colorLiteral(red: 0.2588235294, green: 0.109196921, blue: 0.7254901961, alpha: 0.5)])
        descTxtField.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [ .foregroundColor : #colorLiteral(red: 0.2588235294, green: 0.08388767616, blue: 0.7254901961, alpha: 0.5)])
    }
    @objc func hideKeyBoard(){
        self.view.endEditing(true)
    }
}

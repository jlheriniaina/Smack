//
//  AvatarPickerViewController.swift
//  Smack
//
//  Created by lucas on 16/01/2019.
//  Copyright © 2019 lucas. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var item = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: item)
            return cell
      }
     return AvatarCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfCollums : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfCollums = 4
        }
        let spaceBetwenCell: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfCollums - 1) * spaceBetwenCell) / numberOfCollums
        return CGSize(width: cellDimension, height: cellDimension)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if item == .dark {
          UserSessionManager.instance.setAvatar(avatar: "dark\(indexPath.item)")
        }else {
          UserSessionManager.instance.setAvatar(avatar: "light\(indexPath.item)")
        }
       self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onChangeColor(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            item = .dark
        }else {
            item = .ligth
        }
        self.collectionView.reloadData()
    }

}

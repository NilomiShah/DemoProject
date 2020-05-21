//
//  SelectProfileViewController.swift
//  demoProject
//
//  Created by PCQ184 on 19/05/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import UIKit

class SelectProfileViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var saveButton               : UIButton!
    @IBOutlet weak var avatarCollectionView     : UICollectionView!
    @IBOutlet weak var descritionLabel  : UILabel!
    
    // MARK: - Variables
    var avatars: [AvatarList]?
    var selectedIndex: Int = 0
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseviewModel.callMasterApi { (success) in
            if (success == true) {
                self.avatars = Global.shared.masterData?.avatarList
                self.avatarCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func didTapOnCrossButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - Action Methods
extension SelectProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImages", for: indexPath) as! AvtarImageListCell
        cell.selectedImageView.isHidden = (selectedIndex == indexPath.row) ? false : true
        cell.profileImageView.sd_setImage(with: URL(string: avatars?[indexPath.row].imageURL ?? ""), placeholderImage: UIImage(named: ""))
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatars?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        avatarCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 105, height: 105)
    }
    
}

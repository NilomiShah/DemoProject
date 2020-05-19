//
//  SelectProfileViewController.swift
//  demoProject
//
//  Created by PCQ184 on 19/05/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import UIKit

class SelectProfileViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var buttonSave               : UIButton!
    @IBOutlet weak var collectionViewAvtars     : UICollectionView!
    @IBOutlet weak var profilePhotoDescription  : UILabel!
    
    // MARK: - Variables

    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
// MARK: - Action Methods
extension SelectProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImages", for: indexPath) as! AvtarImageListCell
               return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        
    }
}

//
//  ViewController.swift
//  demoProject
//
//  Created by PCQ188 on 06/04/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeCollectionView: UICollectionView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var skipNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapOnCreateAccount(_ sender: Any) {
    }
      
    @IBAction func didTapOnSkipNow(_ sender: Any) {
    }
      
    @IBAction func didTapOnLogIn(_ sender: Any) {
    }
    
    func setColors(index: Int) {
        self.skipNowButton.setTitleColor(index == 0 ? UIColor.white : UIColor(named: "landingColor0"), for: .normal)
        self.logInButton.setTitleColor(index == 0 ? UIColor.white : UIColor(named: "landingColor0"), for: .normal)
        self.logInButton.borderColor = index == 0 ? UIColor.white : UIColor(named: "landingColor0")
    }
}

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return welcomeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WelcomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionViewCell", for: indexPath) as? WelcomeCollectionViewCell ?? WelcomeCollectionViewCell()
        cell.setData(index: indexPath.row, data: welcomeArray[indexPath.row])
        setColors(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
    
}

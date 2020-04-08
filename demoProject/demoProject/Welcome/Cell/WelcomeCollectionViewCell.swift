//
//  WelcomeCollectionViewCell.swift
//  demoProject
//
//  Created by PCQ188 on 07/04/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var welcomeTitleLabel: UILabel!
    @IBOutlet weak var tmroImageView: UIImageView!
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var welcomeImageView: UIImageView!
    
    func setData(index: Int, data: WelcomeModel) {
        tmroImageView.isHidden = (index == 0) ? false : true
        welcomeTitleLabel.isHidden = (index == 0) ? true : false
        welcomeMessageLabel.text = data.message
        welcomeTitleLabel.text = data.title
        self.pageControl.currentPage = index
        pageControl.subviews.forEach {
                   $0.transform = CGAffineTransform(scaleX: 2, y: 2)
               }
        welcomeImageView.image = UIImage(named: "landing\(index)")
        setColors(index: index)
    }
    
    func setColors(index: Int) {
        self.welcomeMessageLabel.textColor = index == 0 ? UIColor.white : UIColor(named: "welcomeTitleColor")
        self.welcomeTitleLabel.textColor = index == 0 ? UIColor.white : UIColor(named: "welcomeTitleColor")
        self.contentView.backgroundColor = UIColor(named: "landingColor\(index)")
        self.pageControl.currentPageIndicatorTintColor = UIColor(named: "landingPageSelectedColor\(index)")
    }
    
}

//
//  RadioTableViewCell.swift
//  TMRO
//
//  Created by PCQ183 on 29/01/20.
//  Copyright © 2020 Sagar Prajapati. All rights reserved.
//

import UIKit

class RadioTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var imageview: UIImageView!
    
    // MARK: - Variable
    var setData: ClientOrCreatorModel! {
        didSet {
            self.manageCell()
        }
    }
    
    // MARK: - load Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - SetUp UI
    private func manageCell() {
        self.labelTitle.text = self.setData.title
        if self.setData.isSelected == true {
            self.labelTitle.textColor = UIColor(named: "textDark") ?? UIColor.black
            self.imageview?.image = UIImage(named: "selectedRadio")
            
        } else {
            self.labelTitle.textColor =  UIColor(named: "textDarkLight") ?? UIColor.darkGray
            self.imageview?.image = UIImage(named: "unselectedRadio")
        }
    }
}

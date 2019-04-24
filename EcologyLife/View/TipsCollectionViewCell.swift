//
//  TipsCollectionViewCell.swift
//  EcologyLife
//
//  Created by Полина on 11/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tipsNameLabel: UILabel!
    @IBOutlet weak var tipsImageView: UIImageView!
    
    var tipsMenu: Tip? {
        didSet {
            tipsNameLabel.text = tipsMenu?.tipsName
            if let image = tipsMenu?.tipsImageName {
                tipsImageView.image = UIImage(named: image)
                tipsImageView.layer.cornerRadius = 16.0
                tipsImageView.clipsToBounds = true
            }
        }
    }
}

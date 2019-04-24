//
//  MenuCollectionViewCell.swift
//  EcologyLife
//
//  Created by Полина on 11/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit

class ArticlesCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var menu: Article? {
        didSet {
            nameLabel.text = menu?.name
            nameLabel.adjustsFontSizeToFitWidth = true
            nameLabel.font = UIFont(name: "Georgia", size: 25)
            if let image = menu?.imageName {
                imageView.image = UIImage(named: image)
                imageView.layer.cornerRadius = 16.0
                imageView.clipsToBounds = true
            }
        }
    }
}

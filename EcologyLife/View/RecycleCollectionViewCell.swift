//
//  RecycleCollectionViewCell.swift
//  EcologyLife
//
//  Created by Полина on 11/03/2019.
//  Copyright © 2019 Polina. All rights reserved.
//

import UIKit

class RecycleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var recycleNameLabel: UILabel!
    @IBOutlet weak var recycleImageView: UIImageView!
    
    var recycleMenu: RecycleArticle? {
        didSet {
            recycleNameLabel.text = recycleMenu?.recycleName
            recycleNameLabel.font = UIFont(name: "Georgia", size: 25)
            if let image = recycleMenu?.recycleImageName {
                recycleImageView.image = UIImage(named: image)
                recycleImageView.layer.cornerRadius = 16.0
                recycleImageView.clipsToBounds = true
            }
        }
    }
}

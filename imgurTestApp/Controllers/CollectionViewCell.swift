//
//  CollectionViewCell.swift
//  imgurTestApp
//
//  Created by Admin on 01/10/2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configure (model: Image) {
        if let url = URL(string: model.imageLink) {
            image.kf.indicatorType = .activity
            image.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.png") )
        }
        label.text = model.title
    }
}

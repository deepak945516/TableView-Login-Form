//
//  PhotosCollectionViewCell.swift
//  TableForm
//
//  Created by Deepak Kumar on 17/05/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //shadow
        imageView.layer.masksToBounds = false
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowRadius = 0.1
        
        imageView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
    }

}

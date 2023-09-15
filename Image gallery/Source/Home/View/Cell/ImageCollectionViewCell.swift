//
//  ImageCollectionViewCell.swift
//  Image gallery
//
//  Created by Narek Matosyan on 24.01.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var representedIdentifier: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

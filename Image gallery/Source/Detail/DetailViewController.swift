//
//  DetailViewController.swift
//  Image gallery
//
//  Created by David Pavliashvili on 24.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    var image: UIImage?
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImageView.image = image
    }

}

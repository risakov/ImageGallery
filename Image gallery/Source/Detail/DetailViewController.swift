//
//  DetailViewController.swift
//  Image gallery
//
//  Created by David Pavliashvili on 24.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    var image: UIImage?
    var username: String?
    var imageDescription: String?
    var date: String?
    
    @IBOutlet weak var detailImageView: UIImageView!
        
    @IBOutlet weak var detailUsernameView: UILabel!
    
    @IBOutlet weak var detailImageDescriptionView: UILabel!
    
    @IBOutlet weak var detailDateView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImageView.image = image
        detailDateView.text = date
        detailImageDescriptionView.text = imageDescription
        detailUsernameView.text = username
    }
}

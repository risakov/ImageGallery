//
//  DetailViewController.swift
//  Image gallery
//
//  Created by David Pavliashvili on 24.01.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    var imageUrl: String?
    var username: String?
    var imageDescription: String?
    var date: String?
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailUsernameView: UILabel!
    @IBOutlet weak var detailImageDescriptionView: UILabel!
    @IBOutlet weak var detailDateView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: imageUrl ?? "") {
            detailImageView.kf.setImage(with: url)
        }
        detailDateView.text = date
        detailImageDescriptionView.text = imageDescription
        detailUsernameView.text = username
    }
}

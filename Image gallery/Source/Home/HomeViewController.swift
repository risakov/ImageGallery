//
//  HomeViewController.swift
//  Image gallery
//
//  Created by Narek Matosyan on 19.01.2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var emptyStateStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyStateStackView.isHidden = true
    }
}

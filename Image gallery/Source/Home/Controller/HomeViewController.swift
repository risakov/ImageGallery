//
//  HomeViewController.swift
//  Image gallery
//
//  Created by Narek Matosyan on 19.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var emptyStateStackView: UIStackView!
    
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        if  sender.selectedSegmentIndex == 0 {
            popularView.alpha = 1
            newView.alpha = 0
        } else {
            popularView.alpha = 0
            newView.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Gallery"
        emptyStateStackView.isHidden = true
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 17)!]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .normal)
        
    }
}

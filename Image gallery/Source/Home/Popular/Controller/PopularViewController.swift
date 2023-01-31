//
//  PopularViewController.swift
//  Image gallery
//
//  Created by Narek Matosyan on 24.01.2023.
//

import UIKit

class PopularViewController: UIViewController {

    private let reuseIdentifier = "imageCollectionViewCellIdentifier"

    let imageNameArray = [ "pic1", "pic2", "pic3", "pic4", "pic5", "pic6", "pic7", "pic8", "pic9", "pic10", "pic11", "pic12", "pic13", "pic14", "pic15", "pic16", "pic17", "pic18", "pic19", "pic20", "pic21", "pic22", "pic23", "pic24", "pic25"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "imageCollectionViewCellIdentifier")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}

extension PopularViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = UIImage(named: imageNameArray[indexPath.row])
        return cell
        
    }
    
}

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insertForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

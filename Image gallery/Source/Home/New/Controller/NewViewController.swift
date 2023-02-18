//
//  NewViewController.swift
//  Image gallery
//
//  Created by Narek Matosyan on 24.01.2023.
//

import UIKit

class NewViewController: UIViewController {
    private let reuseIdentifier = "imageCollectionViewCellIdentifier"
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    let networker = NetworkManager.shared
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networker.posts(query: "cats") { [weak self] posts, error in
            if let error = error {
                print("error", error)
                return
            }
            
            self?.posts = posts!
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func image(data: Data?) -> UIImage? {
        if let data = data {
            return UIImage(data: data)
        }
        return UIImage(systemName: "picture")
    }
}

extension NewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        let post = posts[indexPath.item]
        
        cell.imageView.image = nil
        let representedIdentifier = post.id
        cell.representedIdentifier = representedIdentifier
        
        networker.image(post: post) { [weak self] data, error in
            guard let img = self?.image(data: data) else { return }
            DispatchQueue.main.async {
                if (cell.representedIdentifier == representedIdentifier) {
                    cell.imageView.image = img
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.item]
        let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "detailStoryboardID") as! DetailViewController
        
        networker.image(post: post) { [weak self] data, error in
            guard let img = self?.image(data: data) else { return }
            DispatchQueue.main.async {
                detailViewController.image = img
                self?.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
}

extension NewViewController: UICollectionViewDelegateFlowLayout {
    
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

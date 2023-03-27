//
//  PopularViewController.swift
//  Image gallery
//
//  Created by Narek Matosyan on 24.01.2023.
//

import UIKit
import Kingfisher

class PopularViewController: UIViewController {
    
    private let reuseIdentifier = "imageCollectionViewCellIdentifier"
    private let query = "dogs"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let networker = NetworkManager.shared
    
    var posts: [Post] = []
    var refreshControl = UIRefreshControl()
    var isLoading = false                           //Флаг, который означает загрузку в данный момент
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshControl
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil) //Переменная содержащая ксиб
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier) // Говорим коллекции, что ячейки должны быть такие как ксиб файл
        collectionView.dataSource = self  //Связываем коллекцию и наш вьюконтроллер (Отвечает за кол-во ячеек и тд)
        collectionView.delegate = self
        fetchImages(withQuery: query)
    }
    
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {   //Вызывается метод для каждой отдельной ячейки, перед тем как они покажутся на экране
            if indexPath.item == posts.count - 1 && !isLoading {                  //Индекс ячейки
                loadMoreData()
    } 
}

func loadMoreData() {             // Функция для загрузки новой пачки
    if !self.isLoading {
        self.isLoading = true
        self.currentPage += 1
        self.fetchImages(withQuery: self.query)
    }
}
    
    @objc func refresh(send: UIRefreshControl) {
        posts = []
        currentPage = 0
        fetchImages(withQuery: query)
    }
    
    func fetchImages(withQuery query: String) {
        networker.getPosts(query: query, page: 0) { [weak self] posts, error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in }))
                self?.present(alert, animated: true, completion: nil)
                self?.refreshControl.endRefreshing()
                return
            }
            guard let posts = posts else { return }
            self?.posts += posts
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.refreshControl.endRefreshing()
                self?.isLoading = false
            }
        }
    }
}

extension PopularViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        let post = posts[indexPath.item]
        let representedIdentifier = post.id
        cell.representedIdentifier = representedIdentifier
        if let url = URL(string: post.urls.regular) {
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.item]
        let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "detailStoryboardID") as! DetailViewController
        detailViewController.date = post.created_at.imageGalleryDateFormat()
        detailViewController.username = post.user.username
        detailViewController.imageDescription = post.description
        detailViewController.imageUrl = post.urls.regular
        self.navigationController?.pushViewController(detailViewController, animated: true)
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
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

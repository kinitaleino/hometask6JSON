//
//  CollectionViewController.swift
//  hometaskFive
//
//  Created by kinitaleino on 12/12/20.
//  Copyright © 2020 kinitaleino. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isActive: Bool = false
    
    private var photos: [Photo] = []

    @IBAction func downloadButton(_ sender: Any) {
        isActive = !isActive
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName:"CollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "CollectionViewCell")
        setupPhotos()

    }
    
    private func setupPhotos(){
        photos = Array(repeating: Photo(url: "https://picsum.photos/500"), count: 40)
    }


}

extension CollectionViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        if isActive{
            cell.setImage(photoModel: photos[indexPath.item]){[weak self] image in
            self?.photos[indexPath.item].image = image
            }}
        return cell
    }
}
extension CollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width - 30
        let width = viewWidth/3
        return CGSize(width:width, height:width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

struct Photo {
    let url: String
    var image: UIImage?
    
    init(url: String) {
        self.url = url
    }
}

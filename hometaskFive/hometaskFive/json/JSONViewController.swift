//
//  JSONViewController.swift
//  hometaskFive
//
//  Created by kinitaleino on 12/15/20.
//  Copyright © 2020 kinitaleino. All rights reserved.
//

import UIKit

final class JSONViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var photos: [PhotoCodable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName:"ImageCell", bundle:nil), forCellWithReuseIdentifier: "ImageCell")
        setupPhotos()
        
    }
    
    private func setupPhotos(){
        guard let imageURL = URL(string: "https://jsonplaceholder.typicode.com/photos") else {return}
        
        URLSession.shared.dataTask(with: imageURL){data, _, _ in
            guard let data = data, let photos = try? JSONDecoder().decode([PhotoCodable].self, from: data) else {return}
            self.photos = photos.prefix(50).map { PhotoCodable(url: $0.url)}
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.resume()
    }
    
    
}

extension JSONViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.setImageURL(photoModel: photos[indexPath.item]) { [weak self] (image) in
                self?.photos[indexPath.item].image = image
            }
        return cell
    }
}
extension JSONViewController: UICollectionViewDelegateFlowLayout{
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




struct PhotoCodable: Codable {
    let url: String
    var image: UIImage?
    
    init(url: String) {
        self.url = url
    }
    
    private enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}

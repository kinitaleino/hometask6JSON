//
//  CollectionViewCell.swift
//  hometaskFive
//
//  Created by kinitaleino on 12/12/20.
//  Copyright © 2020 kinitaleino. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    @IBAction func tap(_ sender: Any) {
        let imageForOpen = setImage()
        return imageForOpen
    }
    
    @IBOutlet private weak var imageView:UIImageView!
    
    override func prepareForReuse() {
       imageView.image = nil
    }
    
    func setImage(photoModel: Photo, completion: @escaping(UIImage?) -> Void){
        if let image = photoModel.image{
            imageView.image = image
            return
        }
        
        guard let imageURL = URL(string: photoModel.url) else {return}
        DispatchQueue.global().async{
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
                completion(image)
            }
        }
    }
    
    func setImageWithURLSession(photoModel: Photo, completion: @escaping (UIImage?) -> Void){
        
        if let image = photoModel.image{
            imageView.image = image
            return
        }
        guard let imageURL = URL(string: photoModel.url) else {return}
        
        URLSession.shared.dataTask(with: imageURL) {data, _, _ in
            if let data = data, let image = UIImage(data: data){
                completion(image)
                DispatchQueue.main.async{
                    self.imageView.image = image
                }
            }
            
        }.resume()
    }

    
}

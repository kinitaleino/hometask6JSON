//
//  ImageCell.swift
//  hometaskFive
//
//  Created by kinitaleino on 12/15/20.
//  Copyright © 2020 kinitaleino. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!

    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func setImageURL(photoModel: PhotoCodable, completion: @escaping (UIImage?) -> Void){
        if let image = photoModel.image {
            imageView.image = image
            return
    }
    guard let imageURL = URL(string: photoModel.url) else{return}
    
    URLSession.shared.dataTask(with:imageURL) { data, _, _ in
        if let data = data, let image = UIImage(data: data){
            completion(image)
            DispatchQueue.main.async{
                self.imageView.image = image
            }
        }
    
    }.resume()
}

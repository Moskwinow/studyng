//
//  FriendCollectionCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/27/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import Kingfisher
class FriendCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionImg.kf.indicatorType = .activity
    }
    
   public func configPhoto(with photo: PhotoAlbum) {
    
    self.collectionImg.kf.setImage(with: URL(string: photo.photoUrl))
    
    }
}

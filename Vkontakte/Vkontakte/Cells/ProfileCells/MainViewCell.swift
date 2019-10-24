//
//  MainViewCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/11/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewCell: UITableViewCell {
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var id: Int = 0
    private var photos: Results<PhotoAlbum>?
    fileprivate var notification: NotificationToken?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
    }
    
    public func configure(id: Int) {
        photos = try? Realm().objects(PhotoAlbum.self).filter("ownerId == %@", id)
        
        self.notification = self.photos?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial, .update:
                
                self.profileCollectionView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
}


extension MainViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InsideViewCell", for: indexPath) as! InsideViewCell
        
        cell.scrollImages.kf.setImage(with: URL(string: photos![indexPath.row].photoUrl))
        
        
        return cell
    }
    
    
}

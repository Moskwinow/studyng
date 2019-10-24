//
//  FriendCollectionController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/27/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import RealmSwift

class FriendCollectionController: UICollectionViewController {
    
    fileprivate var photo: Results<PhotoAlbum>?
    var id: Int = 0
    fileprivate var notification: NotificationToken?
    
    
    let dispatch = DispatchGroup()
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetching()
       self.collectionView.reloadData()
       
   }
    override func viewDidAppear(_ animated: Bool) {
        self.indicator.stopAnimating()
    }
    
   
    
    private func fetching(){
            NetworkService.getPhotos(friendId: id) {  photos in
             try? RealmService.save(items: photos)
               
            }
        self.photo = try! Realm().objects(PhotoAlbum.self).filter("ownerId == %@", id)
        
    }
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photo?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionCell", for: indexPath) as! FriendCollectionCell
        
        let photos = photo![indexPath.row]
        
        cell.configPhoto(with: photos)
        
        
        return cell
    }

    
//    Передаем фото в размере

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bigPhoto" {
            let dvc = segue.destination as! BigPhotoController
            guard collectionView.indexPathsForSelectedItems!.count == 1 else {return}
            let index = collectionView.indexPathsForSelectedItems![0].item
            
            dvc.indexPhoto = index
            dvc.userID = id
        }
    }
   
}


//
//  ProfileController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/10/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

//import UIKit
//import Alamofire
//import SwiftyJSON
//
//class ProfileController: UITableViewController {
//    
//    
//   
//
//    var profilee = [Profile]()
//    var photoAlbums = [PhotoAlbum]()
//    var id: Int = 0
//    
//    var photo: String = ""
//    var name: String = ""
//    
//    let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
//
//    //    private func activityStart() {
//    //        indicator.center = self.profPhoto.center
//    //        indicator.hidesWhenStopped = true
//    //        indicator.color = .red
//    //        view.addSubview(indicator)
//    //        indicator.startAnimating()
//    //    }
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetching()
//        ProfileNetworkService.getProfile(userIds: id) { (profile) in
//            self.profilee = profile
//            self.tableView.reloadData()
//        }
//    }
//
//        private func fetching() {
//
//
//            NetworkService.getPhotos(friendId: String(id)) { [weak self] photos in
//                self?.photoAlbums = photos
//
//            }
//    
//        }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return profilee.count
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfCell
//            cell.profName.text = profilee[indexPath.section].fullName
//            cell.profPhoto.kf.setImage(with: URL(string: profilee[indexPath.section].photo))
//            return cell
//
//        default:
//            break
//        }
//        return UITableViewCell()
//    }
//    
//
//
//}
//
//
//extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photoAlbums.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionCell", for: indexPath) as! MediaCollectionCell
//
//        let picture = photoAlbums[indexPath.row]
//        cell.configPhoto(with: picture)
//
//        return cell
//    }
//
//}

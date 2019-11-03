//
//  MainProfileController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/11/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import RealmSwift

class MainProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var countFriendsLabel: UILabel!
    @IBOutlet weak var countGroupsLabel: UILabel!
    @IBOutlet weak var countAudiosLabel: UILabel!
    @IBOutlet weak var countVideosLabel: UILabel!
    
    fileprivate var notification: NotificationToken?
    fileprivate var profile: Results<Profile>?
    @IBOutlet weak var tableViewProf: UITableView!
    @IBOutlet weak var wallTableView: UITableView!
    
    @IBOutlet weak var profPhoto: UIImageView!
    
    @IBOutlet weak var profName: UILabel!
    
    var wall = [Wall]()
    
    var id: Int = 0
    var name: String = ""
    var photo: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configPhoto()
        counters()
        getWall()
    }
    
    //    MARK: Получаем стену
    private func getWall() {
        WallNetworkService.getWall(id: id) {[weak self] (wall) in
            self?.wall = wall
            self?.wallTableView.reloadData()
        }
        print(wall)
    }
    
    
    //    MARK: настраиваем Counters
    private func counters() {
          self.countFriendsLabel.isHidden = true
          self.countGroupsLabel.isHidden = true
          self.countAudiosLabel.isHidden = true
          self.countVideosLabel.isHidden = true
          self.profile = try? Realm().objects(Profile.self).filter("id == %@", id)
         
        ProfileNetworkService.getProfile(userIds: id) { profiles in
            try? RealmService.save(items: profiles)
            self.countFriendsLabel.text = "\(self.profile?[0].countFriend ?? 0)"
            self.countGroupsLabel.text = "\(self.profile?[0].countGroup ?? 0)"
            self.countAudiosLabel.text = "\(self.profile?[0].countAudio ?? 0)"
            self.countVideosLabel.text = "\(self.profile?[0].countVideo ?? 0)"
            self.countFriendsLabel.isHidden = false
            self.countGroupsLabel.isHidden = false
            self.countAudiosLabel.isHidden = false
            self.countVideosLabel.isHidden = false
        }
          
      }
    
    
    //    MARK: Фото для колекции в ячейке
    
    private func configPhoto() {
        profPhoto.layer.cornerRadius = 40
        profPhoto.layer.masksToBounds = true
        profPhoto.layer.borderWidth = 1.5
        profPhoto.layer.borderColor = #colorLiteral(red: 0.6285611999, green: 0.9598697106, blue: 1, alpha: 1)
        
        profName.text = name
        profPhoto.kf.setImage(with: URL(string: photo))
        
        NetworkService.getPhotos(friendId: id) {(photos) in
            try? RealmService.save(items: photos)
        }
        self.tableViewProf.reloadData()
      
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
            
        case tableViewProf:
            
            switch indexPath.row {
                
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as! MainViewCell
                cell.configure(id: id)
                cell.id = id
                return cell
                
            default:
                return UITableViewCell()
            }
            
        case wallTableView:
            
            switch indexPath.row {
                
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WallSourceCell", for: indexPath) as! WallSourceCell
                cell.sourceName.text = name
                cell.sourceImg.kf.setImage(with: URL(string: photo))
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WallTextCell", for: indexPath) as! WallTextCell
//                cell.wallText.text = wall[indexPath.section].text
                return cell
            default:
                return UITableViewCell()
            }
            
             default:
               return UITableViewCell()
        }
       
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collection",
            
            let photoVC = segue.destination as? FriendCollectionController {
            
            photoVC.id = id
            
        }
        
    }
    
}



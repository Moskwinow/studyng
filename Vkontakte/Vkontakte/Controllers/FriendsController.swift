//
//  FriendsController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/20/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import RealmSwift
import PromiseKit

class FriendsController: UITableViewController {
    
    @IBOutlet weak var textSearchBar: UISearchBar! {
        didSet {
            textSearchBar.delegate = self
        }
    }
    
    fileprivate var notification: NotificationToken?
    
    fileprivate var friendD: Results<Friend>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetching()
        fetchAll()
    }
    
    private func fetchAll() {
        
        
        NetworkService.getGroups { group in
            
            try? RealmService.save(items: group)
            
        }
        
    }
    
    // MARK: - Private helpers
    
    private func fetching() {
        friendD = try? Realm().objects(Friend.self)
        
        self.notification = self.friendD?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                self.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.update(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error(let error):
                print(error)
            }
        }
        
        NetworkService.getFriend(on: .global()).get { friends in
                try? RealmService.save(items: friends)

            }.done(on: .main) { [weak self] friends in
                self?.friendD = try Realm().objects(Friend.self)
                
            }
            .catch { [weak self] error in
                self?.show(error)
                
        }

        
    }
    
    deinit {
        notification?.invalidate()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendD?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        let friends = friendD?[indexPath.row]
        cell.config(with: friends!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "cl",
//
//            let photoVC = segue.destination as? FriendCollectionController,
//            let indexPath = tableView.indexPathForSelectedRow {
//            let friends = friendD![indexPath.row]
//            photoVC.id = friends.id
//        }
        if segue.identifier == "MainProfileController",
            let profVc = segue.destination as? MainProfileController,
            let index = tableView.indexPathForSelectedRow {
            let friend = friendD![index.row]
            profVc.id = friend.id
            profVc.name = friend.name
            profVc.photo = friend.avatarUrl
        }
        
        
    }
    
    
    //    Анимируем Таблицу
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let transform = CATransform3DRotate(CATransform3DIdentity, -250, 100, 250, -100)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension FriendsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriend(search: searchText)
        tableView.reloadData()
    }
    
    private func filterFriend(search text: String) {
        if text.isEmpty {
            friendD = try? RealmService.get(Friend.self)
            tableView.reloadData()
            return
        }
        
        friendD = try? RealmService.get(Friend.self).filter("name CONTAINS[cd] %@", text)
        tableView.reloadData()
        
    }
    

}






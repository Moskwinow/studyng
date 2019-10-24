//
//  GroupsController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/23/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsController: UITableViewController {
    
    fileprivate var groupD: Results<Group>?
    fileprivate var notification: NotificationToken?
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        groupD = try? Realm().objects(Group.self)
        notification = groupD?.observe { change in
            switch change {
            case .initial:
                self.tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.update(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error(let error):
                print(error)
                
            }
            
        }
    }
    
    deinit {
        notification?.invalidate()
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupD?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
        
        let group = groupD![indexPath.row] 
        
        cell.configGroup(with: group)
        
        return cell
    }
    
    
    //    Анимируем Таблицу
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let transform = CATransform3DRotate(CATransform3DConcat(CATransform3DMakeRotation(23, 344, 23, 32), CATransform3DIdentity), 23, -123, +234, 222)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
    
}

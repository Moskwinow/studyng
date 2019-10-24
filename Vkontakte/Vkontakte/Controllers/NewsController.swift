//
//  NewsController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 9/20/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import RealmSwift

class NewsController: UITableViewController {
    
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            NetworkService.getNews(sourceID: "groups") { [ weak self ] newss in
                guard let self = self else { return }
                self.news = newss
                self.tableView.reloadData()
            }
    }
    
    // MARK: - Table view data source
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
//        let newss = news[section]
//        if newss.itemText != "" {count += 1}
//        if newss.photo != "" {count += 1}
//        if !newss.comments.isEmpty , !newss.itemText.isEmpty  , !newss.likes.isEmpty , !newss.watches.isEmpty  {count += 1}
       return 4
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerCell", for: indexPath) as? OwnerCell
                let sourceId = news[indexPath.section].sourceID
                let groups = try! Realm().objects(Group.self).filter("id == %@", -sourceId)
                let filteGroups = groups
                filteGroups.forEach {
                    cell?.nameGroupNews.text = $0.name
                    cell?.avatarGroupNews.kf.setImage(with: URL(string: $0.avatarUrl))
            }
            return cell!
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as? TextCell
            cell?.configText(news: news[indexPath.section])
            return cell!
            
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as? MediaCell {
                cell.photoGroupNews.kf.setImage(with: URL(string: news[indexPath.section].photo))
                return cell
            }
                return MediaCell()
            
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CounterCell", for: indexPath) as?  LikesCommetsViewsCell
                cell?.comments.text = news[indexPath.section].comments
                cell?.likes.text = news[indexPath.section].likes
                cell?.share.text = news[indexPath.section].shares
                cell?.watch.text = news[indexPath.section].watches
                return cell ?? LikesCommetsViewsCell()
        default:
             return UITableViewCell()
        }
    }
}

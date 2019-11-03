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
    var photo: String?
    var gif: String?
    var news = [News]()
    var textChache: [IndexPath: String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
            NetworkService.getNews(sourceID: "groups") { [ weak self ] newss in
                guard let self = self else { return }
                self.news = newss
                self.tableView.reloadData()
            }
    }
//    MARK: Настраиваем ячейку чтобы не переиспользовала текст
    
    func getTextChache(forIndexPath indexPath: IndexPath, andText text: String) -> String {
        if let stringText = textChache[indexPath]{
            return stringText
        } else {
            let text = news[indexPath.section]
            textChache[indexPath] = text.itemText
            return text.itemText
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
        var count = 2
        let newsCount = news[section]
        if !newsCount.itemText.isEmpty {count += 1}
        if !newsCount.photo.isEmpty {count += 1}
         if !newsCount.gif.isEmpty {count += 1}
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
            cell?.textGroupNews.text = getTextChache(forIndexPath: indexPath, andText: news[indexPath.row].itemText)
            return cell!
            
        case 2:
             let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as! MediaCell
                (cell.photoGroupNews.kf.setImage(with: URL(string: news[indexPath.section].gif)) != nil) || (cell.photoGroupNews.kf.setImage(with: URL(string: news[indexPath.section].photo)) != nil)
                return cell
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

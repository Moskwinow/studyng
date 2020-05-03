//
//  News.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/27/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class News: Object {
    
    
    @objc dynamic var itemText: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var gif: String = ""
    @objc dynamic var sourceID: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var likes: String = ""
    @objc dynamic var comments: String = ""
    @objc dynamic var shares: String = ""
    @objc dynamic var watches: String = ""
    
    
   convenience init(_ json: JSON) {
        self.init()
        self.gif = json["attachments"][0]["doc"]["url"].stringValue
        self.photo = json["attachments"][0]["photo"]["sizes"][4]["url"].stringValue
        self.itemText = json["text"].stringValue
        self.type = json["type"].stringValue
        self.sourceID = json["source_id"].intValue
        self.likes = json["likes"]["count"].stringValue
        self.comments = json["comments"]["count"].stringValue
        self.shares = json["reposts"]["count"].stringValue
        self.watches = json["views"]["count"].stringValue
    
    }

    override static  func primaryKey() -> String {
        return "sourceID"
    }
    
}

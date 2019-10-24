//
//  Friend.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/27/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RealmSwift

class Friend: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var avatarUrl: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var id: Int = 0
    
    
   convenience init(_ json: JSON) {
        self.init()
        self.name = json["first_name"].stringValue + " " + json["last_name"].stringValue
        self.avatarUrl = json["photo_50"].stringValue
        self.online = json["online"].intValue
        self.id = json["id"].intValue
    
    }
    
    override static  func primaryKey() -> String {
        return "id"
    }
    
    
}

class PhotoAlbum: Object {
    
    
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var itemId: Int = 0
    
   convenience init(json: JSON) {
    self.init()
        self.ownerId = json["owner_id"].intValue
        self.photoUrl = json["sizes"][4]["url"].stringValue
        self.itemId = json["id"].intValue
    
    }
    
    override static  func primaryKey() -> String {
        return "itemId"
    }
    
    
}


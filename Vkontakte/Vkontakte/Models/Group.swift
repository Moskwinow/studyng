//
//  Group.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/27/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object
{
    @objc dynamic var name: String = ""
    @objc dynamic var avatarUrl: String = ""
    @objc dynamic var member: Int = 0
    @objc dynamic var id: Int = 0
    
   convenience init(_ json: JSON) {
    self.init()
        self.name = json["name"].stringValue
        self.avatarUrl = json["photo_50"].stringValue
        self.member = json["is_member"].intValue
        self.id = json["id"].intValue
    }
    
  override static  func primaryKey() -> String {
        return "id"
    }
    
    
}




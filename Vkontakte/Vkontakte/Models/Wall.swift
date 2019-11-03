//
//  Wall.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/25/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class Wall: Object {
    
    @objc dynamic var text: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var sourceId: Int = 0
    @objc dynamic var type: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.text = json["text"].stringValue
        self.photo = json["attachments"]["photo"]["sizes"]["type"]["q"]["url"].stringValue
        self.sourceId = json["source_id"].intValue
        self.type = json["type"].stringValue
        
    }
    
    override static  func primaryKey() -> String {
        return "sourceId"
    }
}

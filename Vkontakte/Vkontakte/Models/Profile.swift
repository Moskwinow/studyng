//
//  Profile.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/5/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Profile: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var fullName: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var countFriend: Int = 0
    @objc dynamic var countGroup: Int = 0
    @objc dynamic var countAudio: Int = 0
    @objc dynamic var countVideo: Int = 0
    
    convenience init(_ json: JSON) {
        self.init()
        self.countFriend = json["counters"]["friends"].intValue
        self.countGroup = json["counters"]["mutual_friends"].intValue
        self.countAudio = json["counters"]["audios"].intValue
        self.countVideo = json["counters"]["videos"].intValue
        self.id = json["id"].intValue
        self.fullName = json["first_name"].stringValue + " " +  json["last_name"].stringValue
        self.photo = json["photo_100"].stringValue
    }
    
    override static  func primaryKey() -> String {
        return "id"
    }
}

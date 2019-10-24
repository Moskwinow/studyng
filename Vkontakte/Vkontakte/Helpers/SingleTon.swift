//
//  SingleTon.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/22/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import Foundation

class User {
    
    
    
    private init()  { }
    
    static var shared = User()

    var id: Int = 0
    var accessToken: String = ""
    var name: String = ""
    
   
    
}

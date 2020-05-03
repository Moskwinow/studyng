//
//  WallNetworkService.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/25/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import Alamofire
import SwiftyJSON
import PromiseKit

class WallNetworkService {
    
    static let session: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let session = SessionManager(configuration: config)
        return session
    }()
 
    static func getWall(id: Int, completion: @escaping ([Wall]) -> Void) {
        
        let url = "https://api.vk.com"
        let path = "/method/wall.get"
        
        let params: Parameters = [
            "access_token": User.shared.accessToken,
            "owner_id": id,
            "count": 1,
            "filter": "owner",
            "extended": 1,
            
            "v": "5.102"
        ]
        
        WallNetworkService.session.request(url+path, method: .get, parameters: params).responseJSON { response in
                switch response.result {
                case .success(let json):
                    let dispatchGroup = DispatchGroup()
                    DispatchQueue.global().async(group: dispatchGroup, qos: .background, execute: {
                        let json = JSON(json)
                        
                        let wallJson = json["response"]["items"].arrayValue
                        
                        let wall = wallJson.map { Wall($0) }
                        print(wall)
                        
                        dispatchGroup.notify(queue: .main) {
                            completion(wall)
                        }
                    })
                    
                   
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        
        
    }
    
    


//
//  ProfileNetworkService.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/5/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//


import Alamofire
import SwiftyJSON
import PromiseKit

class ProfileNetworkService {
    
    static let session: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let session = SessionManager(configuration: config)
        return session
    }()
    
   
    
     static func getProfile(userIds: Int, completion: @escaping ([Profile]) -> Void) {
           
           let url = "https://api.vk.com"
           let path = "/method/users.get"
           
           let params: Parameters = [
               "user_ids": userIds,
               "fields": "photo_id, counters, verified, sex, bdate, city, country, home_town, has_photo,  photo_50, photo_100",
               "access_token": User.shared.accessToken,
               "v": "5.101"
           ]
           
           ProfileNetworkService.session.request(url+path, method: .get, parameters: params).responseJSON { response in
               switch response.result {
               case .success(let json):
                   let dispatchGroup = DispatchGroup()
                   DispatchQueue.global().async(group: dispatchGroup, qos: .background, execute: {
                       let json = JSON(json)
                       let profileJson = json["response"].arrayValue
                       
                       let profile = profileJson.map { Profile($0) }
                       
                       dispatchGroup.notify(queue: .main) {
                           completion(profile)
                        print(profile)
                       }
                   })
                   
                  
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
       
//
//            switch response.result {
//            case .success(let json):
//
//                    let json = JSON(json)
//                    let profileJson = json["response"].arrayValue
//
//                    let profile = profileJson.map { Profile($0) }
//
//
//
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    
    
    static func fetchImage(by url: URL, completion: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        NetworkService.session.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data)
                    else {
                        
                        return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}



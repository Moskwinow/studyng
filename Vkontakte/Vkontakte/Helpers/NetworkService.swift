//
//  NetworkService.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/20/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit


class NetworkService {
    
//    Создаем сессиию
    
    static let session: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let session = SessionManager(configuration: config)
        return session
    }()
    

    
    
// Получем фото друзей
   
    static func getPhotos(friendId: Int, completion: @escaping ([PhotoAlbum]) -> Void) {
        
        let url =  "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "user_id": User.shared.id,
            "owner_id": friendId,
            "extended": 1,
            "no_service_albums": 0,
            "count": 200,
            "access_token": User.shared.accessToken,
            "v": "5.101"
        ]
        
        NetworkService.session.request(url+path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                    let dispatchGroup = DispatchGroup()
                    
                    DispatchQueue.global().async(group: dispatchGroup) {
                        let json = JSON(value)
                        let photosJson = json["response"]["items"].arrayValue
                        let photo = photosJson.map {PhotoAlbum(json: $0)}
                        
                        dispatchGroup.notify(queue: .main) {
                            completion(photo)
                        }
                    }
                    
            case .failure(let error):
                completion([error as! PhotoAlbum])
            }
        }
        
    }
    
    
//    Получаем данные друзей
    
    static func getFriend(on queue: DispatchQueue = .main) -> Promise<[Friend]> {
        
        let url =  "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": User.shared.accessToken,
            "order": "hints",
            "fields": ["photo_50", "online"],
            "name_case": "nom",
            "v": "5.92"
        ]
        
//      Парсим данные для друзей
        
        return  NetworkService.session.request(url+path, method: .get, parameters: params).responseJSON().map(on: queue) { json, response -> [Friend] in
            let json = JSON(json)
            let jsonFriend = json["response"]["items"].arrayValue.map { Friend($0) }
            
            return jsonFriend
       }
//                { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//
//                let friendJson = json["response"]["items"].arrayValue
//
//                let friends = friendJson.map {Friend($0)}
//
//
//            case .failure(let error):
//
//            }
//
//        }

    }
    
//    Получаем картинку друзей
    
    static func fetchImage(by url: URL, completion: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        NetworkService.session.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data)
                    else {
                        completion(.failure(MyError.imageCannotBeFetched))
                        return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
//    Получаем данные для групп
    
    static func getGroups(completion: @escaping ([Group]) -> Void)  {
        
        let url = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            
            "access_token": User.shared.accessToken,
            "extended": 1,
            "v": "5.101"
            
        ]
        
        NetworkService.session.request(url+path, method: .get, parameters: params).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let groupsJson = json["response"]["items"].arrayValue
                
                let group = groupsJson.map {Group($0)}
                completion(group)
                
            case .failure(let error):
                completion(error as! [Group])
            }
            
        }
    }
    

    
//    Получаем данные новостей
    
    static func getNews(sourceID: Any,  completion: @escaping ([News]) -> Void ) {

        let url = "https://api.vk.com"
        let path = "/method/newsfeed.get"

        let params: Parameters = [
            "access_token": User.shared.accessToken,
            "source_ids": sourceID,
            "filter" : "post",
            "v": "5.96"
        ]
        
        NetworkService.session.request(url+path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):

                let json = JSON(value)
                let newsJson = json["response"]["items"].arrayValue 
                let newsPost = newsJson.map {News($0)}
                let filter = newsPost.filter {$0.type == "post"}
                completion(filter)
            case .failure(let error):
                completion(error as! [News])
            }
        }
        
 
  }
    
enum MyError: Error {
    case imageCannotBeFetched
    
    }




}

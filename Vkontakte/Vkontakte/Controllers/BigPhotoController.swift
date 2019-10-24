//
//  BigPhotoController.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/27/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift
import Kingfisher

class BigPhotoController: UIViewController {
    
    var bigPhoto: UIImage!
    var userID: Int = 0
    var indexPhoto: Int!
    
    //    var photic: Results<PhotoAlbum>?
    
    @IBOutlet weak var mainImgView: UIImageView!
    
    private lazy var photo = try? Realm().objects(PhotoAlbum.self).filter("ownerId == %@", userID)
    
    private func setImage(indexImage: Int) {
        self.mainImgView.kf.setImage(with: URL(string: (self.photo?[indexPhoto].photoUrl)!))
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        animateRight()
       
        
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        animateLeft()
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImage(indexImage: self.indexPhoto)
        
    }
    
    private func animateLeft() {
        guard indexPhoto < (photo!.count - 1) else { return }
        if indexPhoto >= 0 {
            indexPhoto += 1
            self.setImage(indexImage: self.indexPhoto)
            self.mainImgView.isHidden = true
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
            
            self.mainImgView.transform = CGAffineTransform(translationX: -500, y: 0)
        }) { _ in
            self.mainImgView.transform = .identity
            self.mainImgView.isHidden = false
        }
    }
    
    private func animateRight() {
//        TO
        guard indexPhoto > 0 else { return }
        
        if indexPhoto >= 0 {
            indexPhoto -= 1
            self.setImage(indexImage: self.indexPhoto)
            self.mainImgView.isHidden = true
        }
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .layoutSubviews, animations: {
            
            self.mainImgView.transform = CGAffineTransform(translationX: +500, y: 0)
        }) { _ in
             self.mainImgView.transform = .identity
            self.mainImgView.isHidden = false
        }
    }
}





//
//  FriendCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/22/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import Kingfisher
class FriendCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var onlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photo.layer.cornerRadius = 40
        photo.layer.masksToBounds = true
        photo.layer.borderWidth = 0.5
        photo.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        onlineView.layer.cornerRadius = 10
        onlineView.layer.masksToBounds = true
        
        shadowView.layer.cornerRadius = 40
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: -10, height: +10)
        shadowView.layer.shadowOpacity = 3
        shadowView.layer.shadowRadius = 10
    }
    
    
    
    public func config(with friend: Friend) {
        
//        Отображаем онлайн
        
        if friend.online == 1 {
            onlineView.layer.backgroundColor = #colorLiteral(red: 0.2755518847, green: 1, blue: 0.372275292, alpha: 0.8970070423)
            onlineView.isHidden = false
        } else {
           
            onlineView.isHidden = true
        }
        
//        Передаем параментры друзей
        
        nameLabel.text = friend.name
        
         self.photo.kf.setImage(with: URL(string: friend.avatarUrl))
    }
    
    
}

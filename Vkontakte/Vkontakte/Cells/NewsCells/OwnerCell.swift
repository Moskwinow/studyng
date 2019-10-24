//
//  NewsCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/23/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class OwnerCell: UITableViewCell {
    
    
    @IBOutlet weak var avatarGroupNews: UIImageView!
    @IBOutlet weak var nameGroupNews: UILabel!
   
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarGroupNews.kf.indicatorType = .activity
        avatarGroupNews.layer.cornerRadius = 40
        avatarGroupNews.layer.masksToBounds = true
        avatarGroupNews.layer.borderWidth = 0.5
        avatarGroupNews.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    }


}

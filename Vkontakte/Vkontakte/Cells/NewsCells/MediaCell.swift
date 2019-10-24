//
//  MediaCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 9/20/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {

    @IBOutlet weak var photoGroupNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoGroupNews.kf.indicatorType = .activity
    }

  
}

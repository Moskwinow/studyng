//
//  InsideViewCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/11/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit

class InsideViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scrollImages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollImages.kf.indicatorType = .activity
        
    }
    
}



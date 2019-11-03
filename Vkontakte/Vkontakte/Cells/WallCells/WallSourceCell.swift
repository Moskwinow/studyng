//
//  WallSourceCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 10/25/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit

class WallSourceCell: UITableViewCell {
    
    @IBOutlet weak var sourceImg: UIImageView!
    @IBOutlet weak var sourceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sourceImg.kf.indicatorType = .activity
        sourceImg.layer.cornerRadius = 25
        sourceImg.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

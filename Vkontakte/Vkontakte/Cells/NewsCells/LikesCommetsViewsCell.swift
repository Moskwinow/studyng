//
//  LikesCommetsViewsCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 9/20/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit

class LikesCommetsViewsCell: UITableViewCell {

    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var share: UILabel!
    @IBOutlet weak var watch: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

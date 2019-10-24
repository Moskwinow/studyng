//
//  GroupsCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 8/23/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit
import Kingfisher

class GroupsCell: UITableViewCell {

    @IBOutlet weak var photoGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoGroup.layer.cornerRadius = 40
        photoGroup.layer.masksToBounds = true
        photoGroup.layer.borderWidth = 0.5
        photoGroup.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    }

    public func configGroup(with group: Group) {
        
        nameGroup.text = group.name
        
        self.photoGroup.kf.setImage(with: URL(string: group.avatarUrl))
        
        
    }

}

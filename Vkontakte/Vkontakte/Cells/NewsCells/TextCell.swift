//
//  TextCell.swift
//  Vkontakte
//
//  Created by Максим Вечирко on 9/20/19.
//  Copyright © 2019 Максим Вечирко. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

     @IBOutlet weak var textGroupNews: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    public func configText(news: News) {
        
        if news.itemText != ""  {
            textGroupNews.text = news.itemText
        }
        
    }

}

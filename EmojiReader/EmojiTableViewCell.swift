//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by Ann Yesip on 20.06.2020.
//  Copyright © 2020 Ann Yesip. All rights reserved.
//

// идентификатор чтобы настроивать и работать с ячейкой table view cell.
// является кастомным классом table view cell


import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func set(object: Emoji) {
//      object содержит все нужные нам данные: эмоджи, имя и тд
        self.emojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.descriptionLabel.text = object.description
    }
    
    

}

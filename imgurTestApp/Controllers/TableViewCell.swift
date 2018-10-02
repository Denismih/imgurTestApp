//
//  TableViewCell.swift
//  imgurTestApp
//
//  Created by Admin on 02/10/2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {

    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    ///метод настраивает содержимое ячейки
    func configure (model: Comment) {
        comment.text = model.comment
        author.text = model.author
    }
}

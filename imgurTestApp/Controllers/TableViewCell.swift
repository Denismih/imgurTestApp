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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure (model: Comment) {
        comment.text = model.comment
        author.text = model.author
    }
}

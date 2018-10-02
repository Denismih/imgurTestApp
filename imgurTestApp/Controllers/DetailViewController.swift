//
//  DetailViewController.swift
//  imgurTestApp
//
//  Created by MacBook Pro on 01.10.2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var image : Image = Image()
    var comments : [Comment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imgComments = image.comment {
            comments = Array(imgComments)
        }
        
        
        if let url = URL(string: image.imageLink) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.png") )
        }
    }
   
}


extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return comments.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.configure(model: comments[indexPath.row])
        return cell
    }
    
    
    
}

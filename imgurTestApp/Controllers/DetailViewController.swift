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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var score: UILabel!
    
    var image : Image = Image()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let url = URL(string: image.imageLink) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.png") )
        }
        titleLabel.text = image.title
        points.text = "Points: \(image.points)  "
        score.text = "Score: \(image.score)"
    }
}


extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    ///количество строк в tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return image.comment.count
    }
    
    ///метод настраивает содержимое ячейки в tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.configure(model: image.comment[indexPath.row])
        return cell
    }
    
    
    
}

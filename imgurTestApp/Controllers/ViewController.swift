//
//  ViewController.swift
//  imgurTestApp
//
//  Created by MacBook Pro on 30.09.2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var images : Results<Image>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        images = realm.objects(Image.self)
        
        for page in 0...0 {
            api.getImageData(section: Constants.Section.top, sort: Constants.Sort.top, window: Constants.Window.day, page: page, onSuccess: {
                print(page)
            }) { (error) in
                print(error?.localizedDescription)
            }
        }
        
    }


}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
 
    
    
    
    
}

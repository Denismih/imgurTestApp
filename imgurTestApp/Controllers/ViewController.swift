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
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
         images = realm.objects(Image.self)
        
        for page in 0...0 {
            api.getImageData(section: Constants.Section.top, sort: Constants.Sort.top, window: Constants.Window.day, page: page, onSuccess: {
                print("suc")
               
                self.collectionView.reloadData()
            }) { (error) in
                print(error?.localizedDescription)
            }
        }
        
    }


}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.configure(model: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        let insets = (collectionViewLayout?.minimumInteritemSpacing ?? 0) * CGFloat(Constants.CollectionViewSetup.itemsInRow + 1)
        let width = (collectionView.frame.size.width - insets) / CGFloat(Constants.CollectionViewSetup.itemsInRow)
        let heirgh =  width / CGFloat(Constants.CollectionViewSetup.aspectRatio)
    return CGSize(width: width, height: heirgh)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

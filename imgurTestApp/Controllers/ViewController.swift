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
    var currentPage = 0
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = RealmService.getImages()
        
        //получаем данные для 1 страницы
        api.getImageData(section: Constants.Section.top, sort: Constants.Sort.top, window: Constants.Window.day, page: 0, onSuccess: {
            print("page 0 received")
            self.collectionView.reloadData()
        }) { (error) in
            print(" \(#function) api error - \(error?.localizedDescription)")
        }
    }
}



extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    ///количество ячеек в collectonView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    ///метод кофигурирует содержимое ячейки в collectonView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.configure(model: images[indexPath.row])
        return cell
    }
    
    ///метод задает размер ячейки в зависимости от настроек в Constants.CollectionViewSetup
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        let insets = (collectionViewLayout?.minimumInteritemSpacing ?? 0) * CGFloat(Constants.CollectionViewSetup.itemsInRow + 1)
        let width = (collectionView.frame.size.width - insets) / CGFloat(Constants.CollectionViewSetup.itemsInRow)
        let heirgh =  width / CGFloat(Constants.CollectionViewSetup.aspectRatio)
        return CGSize(width: width, height: heirgh)
    }
    ///метод обновляет collectionViewLayout после изменения ориентации устройства
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    ///метод воспроизводит пагинацию загрузки данных для следующей страницы
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if images[indexPath.row].page >= currentPage {
            currentPage += 1
            api.getImageData(section: Constants.Section.top, sort: Constants.Sort.top, window: Constants.Window.day, page: currentPage, onSuccess: {
                print("page \(self.currentPage) received")
                self.collectionView.reloadData()
            }) { (error) in
                print(" \(#function) api error - \(error?.localizedDescription)")
            }
        }
    }
    
    ///метод вызывает переход на DetailViewController и передачу туда выбранного объекта изображения
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         performSegue(withIdentifier: "detailSegue", sender: images[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destination as! DetailViewController
            if let img = sender as? Image {
                detailVC.image = img
            }
            
        }
    }
}

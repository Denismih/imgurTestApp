//
//  RealmService.swift
//  imgurTestApp
//
//  Created by Admin on 01/10/2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    /// Метод  сохраняет в БД объект изображения и массив комментариев
    /// - Parameter model : Image объект изображения
    /// - Parameter comments :  [Comment] массив комментариев
   
    static func saveImage(model: Image, comments: [Comment]) {
        let realm = try! Realm()
        model.comment.append(objectsIn: comments)
        do {
            try realm.write {
                realm.add(model, update: true)
                //print("Image \(model.id) saved in DB, comments count - \(model.comment.count)")
                }
        } catch let error {
            print("\(#function) error saving model - \(error.localizedDescription)")
        }
    }
    
    ///Метод возвращает из БД массив объектов изображение
    static func getImages() -> (Results<Image>) {
        let realm = try! Realm()
        return realm.objects(Image.self).sorted(byKeyPath: "id").sorted(byKeyPath: "page", ascending: true)
    }
    
    ///метод очищает существующую БД
    static func deleteAll() {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.deleteAll()
                print("DB cleared")
            }
        } catch let error {
            print("\(#function) error deleting model - \(error.localizedDescription)")
        }
    }
}

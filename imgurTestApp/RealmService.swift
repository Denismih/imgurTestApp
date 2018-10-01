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
    
    static func saveImage(model: Image, comments: [Comment]) {
        let realm = try! Realm()
        let commentsList : List<Comment> =  List<Comment>()
        commentsList.append(objectsIn: comments)
        model.comment = commentsList
        do {
            try realm.write {
                realm.add(model, update: true)
                print("Image \(model.id) saved in DB")
                }
        } catch let error {
            print("\(#function) error saving model - \(error.localizedDescription)")
        }
    }
}

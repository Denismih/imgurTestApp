//
//  Image.swift
//  imgurTestApp
//
//  Created by MacBook Pro on 30.09.2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import Foundation
import RealmSwift

/// Модель Realm для объекта Image
class Image : Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var points: Int = 0
    @objc dynamic var score: Int = 0
    @objc dynamic var imageId: String = ""
    @objc dynamic var imageType: String = ""
    @objc dynamic var imageLink: String = ""
    @objc dynamic var page: Int = 0
    let comment = List<Comment>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience  init(id: String, title: String, points: Int, score: Int, imageId: String, imageType: String,  imageLink: String, page: Int ) {
        self.init()
        self.id = id
        self.title = title
        self.points = points
        self.score = score
        self.imageId = imageId
        self.imageType = imageType
        self.imageLink = imageLink
        self.page = page
       
    }
    
}

///Модель Realm для объекта Comment
class Comment : Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var image_id: String = ""
    @objc dynamic var comment: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var downs: Int = 0
    @objc dynamic var ups: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience  init(id: Int, image_id: String, comment: String,  author: String, downs: Int, ups: Int) {
        self.init()
        self.id = id
        self.image_id = image_id
        self.comment = comment
        self.author = author
        self.downs = downs
        self.ups = ups
    }
}

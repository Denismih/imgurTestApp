//
//  ImageAPI.swift
//  imgurTestApp
//
//  Created by MacBook Pro on 30.09.2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift


extension ApiService{
    
    func getImageData (section: String, sort: String, window: String, page: Int, onSuccess: @escaping () -> Void, onFail: @escaping (Error?) -> Void) {
        print("\(#file) - \(#function) URL - \( Constants.ServerURL.imgur)/\(Constants.ServerModel.gallery)/\(section)/\(sort)/\(window)/\(page)")
        let headers = [
            // "Content-Type":"application/json",
            "Authorization":Constants.AuthHeader.clientId
        ]
        
        Alamofire.request("\( Constants.ServerURL.imgur)/\(Constants.ServerModel.gallery)/\(section)/\(sort)/\(window)/\(page)", method: .get,  encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    if response.data != nil {
                        //debugPrint("HTTP Response Body: \(String(data: response.data!, encoding: String.Encoding.utf8))")
                        let json = JSON(response.data!)
                        let imageDict = json.dictionaryObject
                        guard let imageItems = imageDict?["data"] as? [[String:Any]] else {print("\(#function) json decoding error"); return}
                        
                        for item in  imageItems {
                            if let images = item["images"] as? [[String: Any]] {
                                if let imageType = images[0]["type"] as? String {
                                    if imageType == "image/png" || imageType == "image/jpeg" {
                                        
                                        let title = item["title"] ?? ""
                                        let points = item["points"] ?? ""
                                        let score = item["score"] ?? 0
                                        
                                        guard let imageLink = images[0]["link"] as? String,
                                            let id = item["id"] as? String,
                                            let imageId = images[0]["id"] as? String else {
                                                print("\(#function) item json decoding error")
                                                return
                                        }
                                        
                                        api.getImageComments(id: id, sort: Constants.Sort.top, onSuccess: { (comments) in
                                            
                                            let realmImage = Image(id: id, title: title as! String, points: points as! Int, score: score as! Int, imageId: imageId, imageType: imageType, imageLink: imageLink, comment: nil)
                                            print(realmImage)
                                        }, onFail: { (error) in
                                            print("\(#function) get comments error - \(String(describing: error?.localizedDescription)) ")
                                        })
                                        
                                        
                                    }
                                }
                            }
                        }
                        onSuccess()
                    }
                    
                }
                else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                    onFail(response.result.error)
                }
        }
    }
    
    
    
    func getImageComments (id: String, sort: String,  onSuccess: @escaping ([Comment]) -> Void, onFail: @escaping (Error?) -> Void) {
        print("\(#file) - \(#function) URL - \( Constants.ServerURL.imgur)/\(Constants.ServerModel.gallery)/\(id)/comments/\(sort)/")
        let headers = [
            // "Content-Type":"application/json",
            "Authorization":Constants.AuthHeader.clientId
        ]
        
        Alamofire.request("\( Constants.ServerURL.imgur)/\(Constants.ServerModel.gallery)/\(id)/comments/\(sort)/", method: .get,  encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    if response.data != nil {
                        let json = JSON(response.data!)
                        let commentsDict = json.dictionaryObject
                        var comments : [Comment] = []
                        guard let commentsItems = commentsDict?["data"] as? [[String:Any]] else {print("\(#function) json decoding error"); return}
                        for comment in commentsItems {
                            guard let commentid = comment["id"] as? Int else {
                                print("\(#function) comment json decoding error")
                                return
                            }
                            let image_id = comment["image_id"] ?? ""
                            let comm = comment["comment"] ?? ""
                            let author = comment["author"] ?? ""
                            print(author)
                            let downs = comment["downs"] ?? 0
                            let ups = comment["ups"] ?? 0
                            let realmComment = Comment(id: commentid , image_id: image_id as! String, comment: comm as! String, author: author as! String, downs: downs as! Int, ups: ups as! Int)
                            comments.append(realmComment)
                        }
                        onSuccess(comments)
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                    onFail(response.result.error)
                }
        }
    }
}

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
                            guard let id = item["id"] as? String,
                            let title = item["title"] as? String,
                            let points = item["points"] as? Int,
                            let score = item["score"] as? Int
                           // let imagesCount = item["images_count"] as? Int
                           // let imageId = item["images"]?[0]["id"]
                                else {
                                    print("\(#function) item json decoding error")
                                    return
                            }
                            print(id)
                        }
                        onSuccess()
                    }
                    
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                    onFail(response.result.error)
                }
        }
    }
}



//https://api.imgur.com/3/gallery/GZOWkC8/comments/top

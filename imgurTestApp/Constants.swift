//
//  Constants.swift
//  imgurTestApp
//
//  Created by MacBook Pro on 30.09.2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import Foundation
struct  Constants {
    ///URL сервера
    struct ServerURL {
        static let imgur = "https://api.imgur.com/3"
    }
    /// Заголовок авторизации
    struct AuthHeader {
        static let clientId = "Client-ID 5b768967a941aa1"
    }
    
    ///Запрашиваема модель данных сервера
    struct ServerModel {
        static let gallery = "gallery"
        static let comment = "comment"
        static let album = "album"
        static let account = "account"
    }
    ///Раздел галереи
    struct Section {
        static let hot = "hot"
        static let top = "top"
        static let user = "user"
    }
    ///Порядок сортировки галереи
    struct Sort {
        static let viral = "viral"
        static let top = "top"
        static let time = "time"
        static let rising = "rising"
    }
   ///Период (только для раздела top)
    struct Window {
        static let day = "day"
        static let week = "week"
        static let month = "month"
        static let year = "year"
        static let all = "all"
    }
    /// насттройка CollectionView на ViewController
    struct CollectionViewSetup {
        static let itemsInRow = 2
        static let aspectRatio = 2.0 / 3.0
    }
}

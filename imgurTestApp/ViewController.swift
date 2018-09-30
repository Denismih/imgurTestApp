//
//  ViewController.swift
//  imgurTestApp
//
//  Created by MacBook Pro on 30.09.2018.
//  Copyright © 2018 MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getImageData(section: Constants.Section.top, sort: Constants.Sort.top, window: Constants.Window.day, page: 1, onSuccess: {
            print("ok")
        }) { (error) in
            print(error?.localizedDescription)
        }
    }


}


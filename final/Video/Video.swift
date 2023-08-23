//
//  Video.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/21.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var title: String?
    var imageURL: String?
    var isOnlineSource: Bool?
    var sourceURL: String?
    var type: String?
    
    init(title: String, imageURL: String, onlineCheck: Bool, sourceURL: String, type: String){
        self.title = title
        self.imageURL = imageURL
        isOnlineSource = onlineCheck
        self.sourceURL = sourceURL
        self.type = type
    }

}

//
//  GoldClass.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/19.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class GoldenClass: NSObject {
    
    var title: String?
    var content: String?
    var imagePath: String?
    
    init(title: String, content: String, imagePath: String){
        self.title = title
        self.content = content
        self.imagePath = imagePath
    }
    

}


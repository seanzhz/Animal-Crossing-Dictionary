//
//  NewsData.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/9.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class NewsData: NSObject, Decodable{
    
    var title: String
    var subtitle: String
    var author: String
    var resource: String
    var imageURL: String
    var contentURL: String
    var publishDate: String
    
    private enum RootKeys: String, CodingKey{
        case title
        case subtitle
        case author
        case resourcefrom
        case contentURL
        case imageLink
        case publishDate
    }
    
    required init(from decoder: Decoder) throws{
        
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        
        title = try rootContainer.decode(String.self, forKey: .title)
        subtitle = try rootContainer.decode(String.self, forKey: .subtitle)
        imageURL = try rootContainer.decode(String.self, forKey: .imageLink)
        contentURL = try rootContainer.decode(String.self, forKey: .contentURL)
        author = try rootContainer.decode(String.self, forKey: .author)
        resource = try rootContainer.decode(String.self, forKey: .resourcefrom)
        publishDate = try rootContainer.decode(String.self, forKey: .publishDate)
        
    }
    
}

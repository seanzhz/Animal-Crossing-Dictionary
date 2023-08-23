//
//  Sender.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/4.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import MessageKit

class Sender: SenderType {
    var senderId: String
    var displayName: String
    
    init(id: String, name: String) {
        senderId = id
        displayName = name
    }
}

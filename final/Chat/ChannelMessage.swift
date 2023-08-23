//
//  ChannelMessage.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/4.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import MessageKit

class ChannelMessage: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    init(sender: Sender, messageId: String, sentDate: Date, message: String){
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = .text(message)
    }

}

//
//  Chat+CoreDataProperties.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/7.
//  Copyright © 2020 zhz. All rights reserved.
//
//

import Foundation
import CoreData


extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat")
    }

    @NSManaged public var name: String?

}

//
//  Bug+CoreDataProperties.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/20.
//  Copyright © 2020 zhz. All rights reserved.
//
//

import Foundation
import CoreData


extension Bug {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bug> {
        return NSFetchRequest<Bug>(entityName: "Bug")
    }

    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var timeday: String?
    @NSManaged public var price: Int16
    @NSManaged public var imageURL: String?
    @NSManaged public var bugNorth: North?
    @NSManaged public var bugSouth: South?

}

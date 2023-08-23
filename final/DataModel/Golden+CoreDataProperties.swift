//
//  Golden+CoreDataProperties.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/19.
//  Copyright © 2020 zhz. All rights reserved.
//
//

import Foundation
import CoreData


extension Golden {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Golden> {
        return NSFetchRequest<Golden>(entityName: "Golden")
    }

    @NSManaged public var name: String?
    @NSManaged public var content: String?
    @NSManaged public var imagePath: String?

}

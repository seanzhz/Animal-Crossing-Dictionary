//
//  North+CoreDataProperties.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/20.
//  Copyright © 2020 zhz. All rights reserved.
//
//

import Foundation
import CoreData


extension North {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<North> {
        return NSFetchRequest<North>(entityName: "North")
    }

    @NSManaged public var jan: Bool
    @NSManaged public var feb: Bool
    @NSManaged public var mar: Bool
    @NSManaged public var apr: Bool
    @NSManaged public var may: Bool
    @NSManaged public var jun: Bool
    @NSManaged public var jul: Bool
    @NSManaged public var aug: Bool
    @NSManaged public var spe: Bool
    @NSManaged public var oct: Bool
    @NSManaged public var nov: Bool
    @NSManaged public var dec: Bool
    @NSManaged public var northFish: Fish?
    @NSManaged public var northBug: Bug?

}

//
//  FishData.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/16.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class FishData: NSObject, Decodable {
    
    var name: String
    var location: String
    var timeday: String
    var price: Int
    var imageURL: String
    var north: [Bool] = []
    var south: [Bool] = []
    
    
    
    private enum RootKeys: String, CodingKey{
        case name
        case location
        case time
        case price
        case imageLink
        case north = "seasonsNorthernHemisphere"
        case south = "seasonsSouthernHemisphere"
    }
    
    private enum MonthKeys: String, CodingKey {
        case january = "jan"
        case february = "feb"
        case march = "mar"
        case april = "apr"
        case may = "may"
        case june = "jun"
        case july = "jul"
        case august = "aug"
        case september = "sep"
        case october = "oct"
        case november = "nov"
        case december = "dec"
    }
    
    
    required init(from decoder: Decoder) throws{
        
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        
        name = try rootContainer.decode(String.self, forKey: .name)
        location = try rootContainer.decode(String.self, forKey: .location)
        timeday = try rootContainer.decode(String.self, forKey: .time)
        price = try rootContainer.decode(Int.self, forKey: .price)
        imageURL = try rootContainer.decode(String.self, forKey: .imageLink)
        
        // Get the book container for most info
        let northContainer = try rootContainer.nestedContainer(keyedBy:MonthKeys.self, forKey: .north)
        let southContainer = try rootContainer.nestedContainer(keyedBy:MonthKeys.self, forKey: .south)
        
        if let north1 = try? northContainer.decode(Bool.self, forKey: .january){
            north.append(north1)
        }
        
        if let north2 = try? northContainer.decode(Bool.self, forKey: .february){
            north.append(north2)
        }
        
        if let north3 = try? northContainer.decode(Bool.self, forKey: .march){
            north.append(north3)
        }
        
        if let north4 = try? northContainer.decode(Bool.self, forKey: .april){
            north.append(north4)
        }
        
        if let north5 = try? northContainer.decode(Bool.self, forKey: .may){
            north.append(north5)
        }
        
        if let north6 = try? northContainer.decode(Bool.self, forKey: .june){
            north.append(north6)
        }
        
        if let north7 = try? northContainer.decode(Bool.self, forKey: .july){
            north.append(north7)
        }
        
        if let north8 = try? northContainer.decode(Bool.self, forKey: .august){
            north.append(north8)
        }
        
        if let north9 = try? northContainer.decode(Bool.self, forKey: .september){
            north.append(north9)
        }
        
        if let north10 = try? northContainer.decode(Bool.self, forKey: .october){
            north.append(north10)
        }
        
        if let north11 = try? northContainer.decode(Bool.self, forKey: .november){
            north.append(north11)
        }
        
        if let north12 = try? northContainer.decode(Bool.self, forKey: .december){
            north.append(north12)
        }
        
        if let south1 = try? southContainer.decode(Bool.self, forKey: .january){
            south.append(south1)
        }
        
        if let south2 = try? southContainer.decode(Bool.self, forKey: .february){
            south.append(south2)
        }
        
        if let south3 = try? southContainer.decode(Bool.self, forKey: .march){
            south.append(south3)
        }
        
        if let south4 = try? southContainer.decode(Bool.self, forKey: .april){
            south.append(south4)
        }
        
        if let south5 = try? southContainer.decode(Bool.self, forKey: .may){
            south.append(south5)
        }
        
        if let south6 = try? southContainer.decode(Bool.self, forKey: .june){
            south.append(south6)
        }
        
        if let south7 = try? southContainer.decode(Bool.self, forKey: .july){
            south.append(south7)
        }
        
        if let south8 = try? southContainer.decode(Bool.self, forKey: .august){
            south.append(south8)
        }
        
        if let south9 = try? southContainer.decode(Bool.self, forKey: .september){
            south.append(south9)
        }
        
        if let south10 = try? southContainer.decode(Bool.self, forKey: .october){
            south.append(south10)
        }
        
        if let south11 = try? southContainer.decode(Bool.self, forKey: .november){
            south.append(south11)
        }
        
        if let south12 = try? southContainer.decode(Bool.self, forKey: .december){
            south.append(south12)
        }
        
    }
}

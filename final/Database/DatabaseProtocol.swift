//
//  DatabaseProtocol.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/20.
//  Copyright © 2020 zhz. All rights reserved.
//

import Foundation

enum DatabaseChange{
    case add
    case remove
    case update
}

enum ListenerType{
    case fish
    case bug
    case north
    case south
    case chat
    case all
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onFishChange(change: DatabaseChange, fish: [Fish])
    func onBugChange(change: DatabaseChange, bug: [Bug])
    func onChatNameChange(change: DatabaseChange, chatName: [Chat])
}

protocol DatabaseProtocol: AnyObject {
    
    //var defaultFish: Fish {get}
    //Create and return a Fish given a name, location, price, imageURL, timeday
    func addFish(name: String, location: String, imageURL: String, timeday: String, price: Int) -> Fish
    func addBug(name: String, location: String, imageURL: String, timeday: String, price: Int) -> Bug
    func addChatName(name: String) -> Chat
    
    func addNorth(jan:Bool, feb:Bool, mar: Bool, apr: Bool, may: Bool, jun: Bool, jul: Bool, aug: Bool, spe:Bool, oct: Bool, nov: Bool, dec: Bool) -> North
    func addSouth(jan:Bool, feb:Bool, mar: Bool, apr: Bool, may: Bool, jun: Bool, jul: Bool, aug: Bool, spe:Bool, oct: Bool, nov: Bool, dec: Bool) -> South
    //func addNorthToFish(fish: Fish, north: North) -> Bool
    //func addSouthToFish(fish: Fish, north: South) -> Bool
    func deleteFish(fish:Fish)
    func deleteBug(bug:Bug)
    func deleteChatName(chat: Chat)
    func fetchAllBug() -> [Bug]
    func fetchAllFish() -> [Fish]
    func fetchAllChatName() -> [Chat]
    //A way to save changes
    
    //Bug
    func cleanup()
    //A way to add and remove listeners for the fetched results controller
    func removeListeners(listener: DatabaseListener)
    func addListeners(listener: DatabaseListener)
    
}

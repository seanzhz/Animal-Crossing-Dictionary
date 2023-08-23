//
//  CoreDataController.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/20.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: NSObject, DatabaseProtocol, NSFetchedResultsControllerDelegate {

    let DEFAULT_FISH = "Default Fish"

    var listeners = MulticastDelegate<DatabaseListener>()
    var persistentContainer: NSPersistentContainer
    
    //Fetch
    var allFishFetchedResultsController: NSFetchedResultsController<Fish>?
    var allBugFetchedResultsController: NSFetchedResultsController<Bug>?
    var allChatFetchedResultsController: NSFetchedResultsController<Chat>?
    //
    override init() {
    // Load the Core Data Stack
    persistentContainer = NSPersistentContainer(name: "FishAndBugModel")
    persistentContainer.loadPersistentStores() { (description, error) in
        if let error = error {
            fatalError("Failed to load Core Data stack: \(error)") }
    }
    super.init()
        if(fetchAllFish().count == 0){
            defalutFish()
            defalutBug()
        }
       
}
    
    
    
    //Save
    func saveContext(){
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {fatalError("Failed to save to CoreData: \(error)")
            }
        }
    }
    
    //
    func cleanup(){
        saveContext()
    }
    
    //
    func addFish(name: String, location: String, imageURL: String, timeday: String, price: Int) -> Fish {
        let fish = NSEntityDescription.insertNewObject(forEntityName: "Fish", into: persistentContainer.viewContext) as! Fish
        fish.name = name
        fish.location = location
        fish.imageURL = imageURL
        fish.timeday = timeday
        fish.price = Int16(price)
        return fish
    }
    
    func addBug(name: String, location: String, imageURL: String, timeday: String, price: Int) -> Bug {
        let bug = NSEntityDescription.insertNewObject(forEntityName: "Bug", into: persistentContainer.viewContext) as! Bug
        bug.name = name
        bug.location = location
        bug.imageURL = imageURL
        bug.timeday = timeday
        bug.price = Int16(price)
        return bug
    }
    
    func addChatName(name: String) -> Chat {
        let chatName = NSEntityDescription.insertNewObject(forEntityName: "Chat", into: persistentContainer.viewContext) as! Chat
        chatName.name = name
        return chatName
       }
       
    
    func addNorth(jan: Bool, feb: Bool, mar: Bool, apr: Bool, may: Bool, jun: Bool, jul: Bool, aug: Bool, spe: Bool, oct: Bool, nov: Bool, dec: Bool) -> North {
        let north = NSEntityDescription.insertNewObject(forEntityName: "North", into: persistentContainer.viewContext) as! North
        north.jan = jan
        north.feb = feb
        north.mar = mar
        north.apr = apr
        north.may = may
        north.jun = jun
        north.jul = jul
        north.aug = aug
        north.spe = spe
        north.oct = oct
        north.nov = nov
        north.dec = dec
        return north
    }
    
    func addSouth(jan: Bool, feb: Bool, mar: Bool, apr: Bool, may: Bool, jun: Bool, jul: Bool, aug: Bool, spe: Bool, oct: Bool, nov: Bool, dec: Bool) -> South {
        let south = NSEntityDescription.insertNewObject(forEntityName: "South", into: persistentContainer.viewContext) as! South
        south.jan = jan
        south.feb = feb
        south.mar = mar
        south.apr = apr
        south.may = may
        south.jun = jun
        south.jul = jul
        south.aug = aug
        south.spe = spe
        south.oct = oct
        south.nov = nov
        south.dec = dec
        return south
    }
    
    //
    func deleteFish(fish: Fish) {
         persistentContainer.viewContext.delete(fish)
    }
    
    func deleteBug(bug: Bug) {
        persistentContainer.viewContext.delete(bug)
    }
    
    func deleteChatName(chat: Chat) {
        persistentContainer.viewContext.delete(chat)
    }
    
    //MARK: - Database Listener
    
    func removeListeners(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
    func addListeners(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        if listener.listenerType == .fish || listener.listenerType == .all {
            listener.onFishChange(change: .update, fish: fetchAllFish())
        }
        if listener.listenerType == .bug || listener.listenerType == .all {
            listener.onBugChange(change: .update, bug: fetchAllBug())
        }
        if listener.listenerType == .chat || listener.listenerType == .all {
            listener.onChatNameChange(change: .update, chatName: fetchAllChatName())
        }
    }
    
    //MARK: - Fetched Results Controller Protocol Functions
    func controllerDidChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == allFishFetchedResultsController { listeners.invoke { (listener) in
            if listener.listenerType == .fish || listener.listenerType == .all {
                listener.onFishChange(change: .update, fish: fetchAllFish())}
            }
        }
        else if controller == allBugFetchedResultsController { listeners.invoke { (listener) in
            if listener.listenerType == .bug || listener.listenerType == .all {
                listener.onBugChange(change: .update, bug: fetchAllBug())}
            }
        }
        
        else if controller == allChatFetchedResultsController { listeners.invoke { (listener) in
            if listener.listenerType == .chat || listener.listenerType == .all {
                listener.onChatNameChange(change: .update, chatName: fetchAllChatName())}
            }
        }
    }
    
    //MARK:- Core Data Fetch Requests
    func fetchAllFish() -> [Fish] {
        // If results controller not currently initialized
        if allFishFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Fish> = Fish.fetchRequest()
            //Sort by name
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            // Initialize Results Controller
            allFishFetchedResultsController = NSFetchedResultsController<Fish>(fetchRequest:
                fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            // Set this class to be the results delegate
            allFishFetchedResultsController?.delegate = self
            
            do{
                try allFishFetchedResultsController?.performFetch()
            } catch{
                print("Fetch Request Failed: \(error)")
            }
        }
        var fish = [Fish]()
        if allFishFetchedResultsController?.fetchedObjects != nil{
            fish = (allFishFetchedResultsController?.fetchedObjects)!
        }
        return fish
    }
    
    func fetchAllBug() -> [Bug] {
        // If results controller not currently initialized
        if allBugFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Bug> = Bug.fetchRequest()
            //Sort by name
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            // Initialize Results Controller
            allBugFetchedResultsController = NSFetchedResultsController<Bug>(fetchRequest:
                fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            // Set this class to be the results delegate
            allBugFetchedResultsController?.delegate = self
            
            do{
                try allBugFetchedResultsController?.performFetch()
            } catch{
                print("Fetch Request Failed: \(error)")
            }
        }
        var bug = [Bug]()
        if allBugFetchedResultsController?.fetchedObjects != nil{
            bug = (allBugFetchedResultsController?.fetchedObjects)!
        }
        return bug
    }
    
    func fetchAllChatName() -> [Chat] {
              if allChatFetchedResultsController == nil {
                  let fetchRequest: NSFetchRequest<Chat> = Chat.fetchRequest()
                  //Sort by name
                  let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
                  fetchRequest.sortDescriptors = [nameSortDescriptor]
                  // Initialize Results Controller
                  allChatFetchedResultsController = NSFetchedResultsController<Chat>(fetchRequest:
                      fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
                  // Set this class to be the results delegate
                  allChatFetchedResultsController?.delegate = self
                  
                  do{
                      try allChatFetchedResultsController?.performFetch()
                  } catch{
                      print("Fetch Request Failed: \(error)")
                  }
              }
              var chat = [Chat]()
              if allChatFetchedResultsController?.fetchedObjects != nil{
                  chat = (allChatFetchedResultsController?.fetchedObjects)!
              }
              return chat
          }
    
    
    func defalutFish(){
        let defaluFish = addFish(name: "DefalutFish", location: "Sea", imageURL: "https://vignette.wikia.nocookie.net/animalcrossing/images/e/ea/NH-Icon-bitterling.png/revision/latest?cb=20200401003128", timeday: "All day", price: 200)
        defaluFish.fishNorth = addNorth(jan: true, feb: true, mar: true, apr: false, may: false, jun: false, jul: false, aug: false, spe: true, oct: false, nov: false, dec: true)
    }
    
    func defalutBug(){
        let bug = addBug(name: "Bug1", location: "Location1", imageURL: "https://vignette.wikia.nocookie.net/animalcrossing/images/3/3a/NH-Icon-commonbutterfly.png/revision/latest?cb=20200401005428", timeday: "All day", price: 12)
        bug.bugNorth = addNorth(jan: true, feb: true, mar: true, apr: false, may: false, jun: false, jul: false, aug: false, spe: true, oct: false, nov: false, dec: true)
    }
    
    
    
}

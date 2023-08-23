//
//  MyListViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/20.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import NotificationCenter

class MyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DatabaseListener, UNUserNotificationCenterDelegate {
   
    let appDelegate1 = {
       return UIApplication.shared.delegate as! AppDelegate
    }()

    @IBOutlet weak var myListTableView: UITableView!
    @IBOutlet weak var NotificationTurn: UISwitch!
    
    @IBAction func myListSwitch(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedIndex = 1
        }
        else {
            selectedIndex = 2
        }
        self.myListTableView.reloadData()
    }
    
    
    
    //db var
    weak var databaseController:DatabaseProtocol?
    var listenerType: ListenerType = .all
    var currentFish: [Fish] = []
    var currentBug: [Bug] = []
    var selectedIndex = 1
    var currentMonth: Int?

    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if appDelegate1.notificationsEnabled {
            UNUserNotificationCenter.current().delegate = self
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        self.myListTableView.dataSource = self
        self.myListTableView.delegate = self
        //
        getCurrentMonth()
        print(currentMonth)
    }
    

    
    //MARK: -Core data thing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListeners(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListeners(listener: self)
    }
    
    //MARK:- TABLE VIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 1{
            return currentFish.count
        }
        else {
            return currentBug.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedIndex == 1 {
        let fishCell = myListTableView.dequeueReusableCell(withIdentifier: "MyFish", for: indexPath) as! FishBugTableViewCell
        let fish = currentFish[indexPath.row]
        fishCell.locationLabel.text = fish.location
        fishCell.nameLabel.text = fish.name
        fishCell.timeLabel.text = fish.timeday
        fishCell.priceLabel.text = String(fish.price)
        DispatchQueue.global().async {
            guard let imageURL = URL(string: fish.imageURL!) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                fishCell.imageURL.image = image
            }
        }
            return fishCell
        }
        else {
            let fishCell = myListTableView.dequeueReusableCell(withIdentifier: "MyBug", for: indexPath) as! FishBugTableViewCell
            let fish = currentBug[indexPath.row]
            fishCell.locationLabel.text = fish.location
            fishCell.nameLabel.text = fish.name
            fishCell.timeLabel.text = fish.timeday
            fishCell.priceLabel.text = String(fish.price)
            DispatchQueue.global().async {
                guard let imageURL = URL(string: fish.imageURL!) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    fishCell.imageURL.image = image
                }
            }
                return fishCell
            
        }
        
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the specified item to be editable.
           return true
       }
       // Override to support editing the table view.
       // Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete && selectedIndex == 1  {
            self.databaseController!.deleteFish(fish: currentFish[indexPath.row])
               currentFish.remove(at: indexPath.row)
               self.myListTableView.reloadData()
           }
            
            if editingStyle == .delete && selectedIndex == 2  {
             self.databaseController!.deleteBug(bug: currentBug[indexPath.row])
                currentBug.remove(at: indexPath.row)
                self.myListTableView.reloadData()
            }
       }
    //Click event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRow = indexPath.row
        
        if selectedIndex == 1 {
            let output = NorthFishOutput()
            let output1 = SouthFishOutput()
            
            let alert = UIAlertController(title: String(currentFish[selectRow].name!), message:"\(output) \n \(output1)",preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertAction.Style.default, handler: { _ in
                //self.navigationController?.popViewController(animated: true)
                return
            }))
            self.present(alert, animated: true, completion: nil)}
        else{
            let output = NorthBugOutput()
            let output1 = SouthBugOutput()
            
            let alert = UIAlertController(title: String(currentBug[selectRow].name!), message:"\(output) \n \(output1)",preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertAction.Style.default, handler: { _ in
                //self.navigationController?.popViewController(animated: true)
                return
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    //MARK: -Database Lisenter
    func onFishChange(change: DatabaseChange, fish: [Fish]) {
        currentFish = fish
        self.myListTableView.reloadData()
        print(currentFish.count)
    }
    
    func onBugChange(change: DatabaseChange, bug: [Bug]) {
        currentBug = bug
        self.myListTableView.reloadData()
        print(currentBug.count)
       }
 
    func onChatNameChange(change: DatabaseChange, chatName: [Chat]) {
           //
       }
       
    //MARK: -
    
    @IBAction func notificationChange(_ sender: UISwitch) {
        if sender.isOn{
            
            print("ON")
            
            
            guard appDelegate1.notificationsEnabled else {
                print("Notifications not enabled")
                return
            }
            
            if ((currentFish.count + currentBug.count) > 0){
                let content = UNMutableNotificationContent()
                var temp: String?
                if (currentBug.count > 0 && currentFish.count > 0){
                    temp = "Looks like you have a catch BF plan"
                }
                else if (currentFish.count > 0){
                    temp = "Looks like you have a catch-Fish plan"
                }
                else if (currentBug.count > 0){
                    temp = "Looks like you have a catch-Bug plan"
                }
            
                content.title = temp!
                content.body = "Click me to go your wishlist"
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                
                let request = UNNotificationRequest(identifier: "foo", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
            }
        }
        else {
            print("OFF")
        }
        
    }

    //MARK: - Notification function setup
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // The app is active, how do we want to handle notification.
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.notification.request.content.categoryIdentifier {
        // If a general notification then break. We do not need to handle it
        case "GENERAL":
            print("General notification ignore")
            break
        // Only handle our current identifier
        case AppDelegate.CATEGORY_IDENTIFIER:
            
            switch response.actionIdentifier {
            case "decline":
                print("declined")
                break
            case "accept":
                print("accepted")
                break
            case "comment":
                // In this case we know that it is a user response instead. So we can cast it to get the response
                let userResponse = response as! UNTextInputNotificationResponse
                print(userResponse.userText)
                break
            default:
                break
            }
            
        default:
            break
        }
        completionHandler()
    }
    
    //MARK: -Get current month
    
    func getCurrentMonth(){
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        let calendar = Calendar.current
        currentMonth = calendar.component(.month, from: date)
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        print(nameOfMonth)
        
    }
    
    func NorthFishOutput() -> String{
        let selectRow = myListTableView.indexPathForSelectedRow!.row
        var outputNorth = "If you are in NORTH, you can catch it on: "
        if currentFish[selectRow].fishNorth?.jan == true{
            outputNorth += "January. "
        }
        if currentFish[selectRow].fishNorth?.feb == true{
            outputNorth += "February. "
        }
        if currentFish[selectRow].fishNorth?.mar == true{
            outputNorth += "March. "
        }
        if currentFish[selectRow].fishNorth?.apr == true{
            outputNorth += "April. "
        }
        if currentFish[selectRow].fishNorth?.may == true{
            outputNorth += "May. "
        }
        if currentFish[selectRow].fishNorth?.jun == true{
            outputNorth += "June. "
        }
        if currentFish[selectRow].fishNorth?.jul == true{
            outputNorth += "July. "
        }
        if currentFish[selectRow].fishNorth?.aug == true{
            outputNorth += "August. "
        }
        if currentFish[selectRow].fishNorth?.spe == true{
            outputNorth += "Spemtmber. "
        }
        if currentFish[selectRow].fishNorth?.oct == true{
            outputNorth += "October. "
        }
        if currentFish[selectRow].fishNorth?.nov == true{
            outputNorth += "November. "
        }
        if currentFish[selectRow].fishNorth?.dec == true{
            outputNorth += "December."
        }
        return outputNorth
    }
    
    func SouthFishOutput() -> String{
        let selectRow = myListTableView.indexPathForSelectedRow!.row
        var output = "If you are in SOUTH, you can catch it on: "
        if currentFish[selectRow].fishSouth?.jan == true{
            output += "January. "
        }
        if currentFish[selectRow].fishSouth?.feb == true{
            output += "February. "
        }
        if currentFish[selectRow].fishSouth?.mar == true{
            output += "March. "
        }
        if currentFish[selectRow].fishSouth?.apr == true{
            output += "April. "
        }
        if currentFish[selectRow].fishSouth?.may == true{
            output += "May. "
        }
        if currentFish[selectRow].fishSouth?.jun == true{
            output += "June. "
        }
        if currentFish[selectRow].fishSouth?.jul == true{
            output += "July. "
        }
        if currentFish[selectRow].fishSouth?.aug == true{
            output += "August. "
        }
        if currentFish[selectRow].fishSouth?.spe == true{
            output += "Spemtmber. "
        }
        if currentFish[selectRow].fishSouth?.oct == true{
            output += "October. "
        }
        if currentFish[selectRow].fishSouth?.nov == true{
            output += "November. "
        }
        if currentFish[selectRow].fishSouth?.dec == true{
            output += "December."
        }
        return output
    }
    
    func SouthBugOutput() -> String{
        let selectRow = myListTableView.indexPathForSelectedRow!.row
        var output = "If you are in SOUTH, you can catch it on: "
        if currentBug[selectRow].bugSouth?.jan == true{
            output += "January. "
        }
        if currentBug[selectRow].bugSouth?.feb == true{
            output += "February. "
        }
        if currentBug[selectRow].bugSouth?.mar == true{
            output += "March. "
        }
        if currentBug[selectRow].bugSouth?.apr == true{
            output += "April. "
        }
        if currentBug[selectRow].bugSouth?.may == true{
            output += "May. "
        }
        if currentBug[selectRow].bugSouth?.jun == true{
            output += "June. "
        }
        if currentBug[selectRow].bugSouth?.jul == true{
            output += "July. "
        }
        if currentBug[selectRow].bugSouth?.aug == true{
            output += "August. "
        }
        if currentBug[selectRow].bugSouth?.spe == true{
            output += "Spemtmber. "
        }
        if currentBug[selectRow].bugSouth?.oct == true{
            output += "October. "
        }
        if currentBug[selectRow].bugSouth?.nov == true{
            output += "November. "
        }
        if currentBug[selectRow].bugSouth?.dec == true{
            output += "December."
        }
        return output
    }
    
    func NorthBugOutput() -> String{
        let selectRow = myListTableView.indexPathForSelectedRow!.row
        var output = "If you are in SOUTH, you can catch it on: "
        if currentBug[selectRow].bugNorth?.jan == true{
            output += "January. "
        }
        if currentBug[selectRow].bugNorth?.feb == true{
            output += "February. "
        }
        if currentBug[selectRow].bugNorth?.mar == true{
            output += "March. "
        }
        if currentBug[selectRow].bugNorth?.apr == true{
            output += "April. "
        }
        if currentBug[selectRow].bugNorth?.may == true{
            output += "May. "
        }
        if currentBug[selectRow].bugNorth?.jun == true{
            output += "June. "
        }
        if currentBug[selectRow].bugNorth?.jul == true{
            output += "July. "
        }
        if currentBug[selectRow].bugNorth?.aug == true{
            output += "August. "
        }
        if currentBug[selectRow].bugNorth?.spe == true{
            output += "Spemtmber. "
        }
        if currentBug[selectRow].bugNorth?.oct == true{
            output += "October. "
        }
        if currentBug[selectRow].bugNorth?.nov == true{
            output += "November. "
        }
        if currentBug[selectRow].bugNorth?.dec == true{
            output += "December."
        }
        return output
    }
    
    
}

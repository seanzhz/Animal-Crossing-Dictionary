//
//  SettingViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/16.
//  Copyright © 2020 zhz. All rights reserved.
//
/*
import UIKit
import NotificationCenter

class SettingViewController: UIViewController, UNUserNotificationCenterDelegate, DatabaseListener {
    
    let appDelegate = {
       return UIApplication.shared.delegate as! AppDelegate
    }()
   
    weak var databaseController:DatabaseProtocol?
    var listenerType: ListenerType = .all
    var currentFish: [Fish] = []
    var currentBug: [Bug] = []

    @IBOutlet weak var notificationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if appDelegate.notificationsEnabled {
            UNUserNotificationCenter.current().delegate = self
            
        }
        
        let appDelegate1 = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate1.databaseController
        // Do any additional setup after loading the view.
    }
    
    //MARK: -COredata
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           databaseController?.addListeners(listener: self)
       }
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           databaseController?.removeListeners(listener: self)
       }
    
    //MARK: -
       func onFishChange(change: DatabaseChange, fish: [Fish]) {
           currentFish = fish
          
           print(currentFish.count)
       }
       
       func onBugChange(change: DatabaseChange, bug: [Bug]) {
           currentBug = bug
           
           print(currentBug.count)
          }
    
       func onChatNameChange(change: DatabaseChange, chatName: [Chat]) {
              //
          }
    //MARK: -Notificaton
    @IBAction func notificationChange(_ sender: UISwitch) {
        if sender.isOn{
            print("ON")
            
            
            guard appDelegate.notificationsEnabled else {
                print("Notifications not enabled")
                return
            }
            
            if (currentFish.count > 3 || currentBug.count > 3){
            let content = UNMutableNotificationContent()
            
            content.title = "Looks like you have a fish/bug in your wishList"
            content.body = "Click me to go your wishlist"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            
            let request = UNNotificationRequest(identifier: "foo", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
        else {
            print("OFF")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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

}*/

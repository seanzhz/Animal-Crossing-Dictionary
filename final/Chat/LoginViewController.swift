//
//  LoginViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/4.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, DatabaseListener {
    
    weak var databaseController:DatabaseProtocol?
    var listenerType: ListenerType = .all
    let LOGIN_SEGUE = "loginSegue"
    var currentSender: Sender?
    var previousName = [Chat]()
    
    @IBOutlet weak var nameReminderLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var previousNameLabel: UILabel!
    @IBOutlet weak var namebtnvis: UIButton!
    @IBAction func namebtn(_ sender: Any) {
        if previousName.count > 0 {
            nameField.text = previousName[0].name
        }
    }
    
    @IBAction func moreInfobtn(_ sender: Any) {
        moreInfoMessageBox()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController

      
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: -Core data thing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListeners(listener: self)
        
        if previousName.count > 0 {
            previousNameLabel.text = previousName[0].name
            namebtnvis.isHidden = false
            previousNameLabel.isHidden = false
            nameReminderLabel.isHidden = false
        }
        else {
            previousNameLabel.isHidden = true
            namebtnvis.isHidden = true
            nameReminderLabel.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListeners(listener: self)
    }

    @IBAction func login(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty else {
            emptyNameAlert()
            print("Enter a name!")
            return
        }
        
        Auth.auth().signInAnonymously(completion: { (user, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let user = user else {
                return
            }
            
            self.currentSender = Sender(id: user.user.uid, name: self.nameField.text!)
            //store
            if (self.databaseController?.fetchAllChatName().count == 0){
                let addNewName = self.databaseController?.addChatName(name: self.nameField.text!)
            }
            if (self.databaseController?.fetchAllChatName().count == 1){
                self.databaseController?.deleteChatName(chat: self.previousName[0])
                self.databaseController?.addChatName(name: self.nameField.text!)
            }
            self.performSegue(withIdentifier: self.LOGIN_SEGUE, sender: nil)
        })
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == LOGIN_SEGUE {
            let destinationVC = segue.destination as! ChannelsTableViewController
            destinationVC.currentSender = currentSender
        }
    }
    
    //MARK: -
    func onFishChange(change: DatabaseChange, fish: [Fish]) {
        //
    }
    
    func onBugChange(change: DatabaseChange, bug: [Bug]) {
        //
    }
    
    func onChatNameChange(change: DatabaseChange, chatName: [Chat]) {
        previousName = chatName
    }
    
    //MARK: -Alert system
    func emptyNameAlert(){
        let alert = UIAlertController(title: "Empty Name", message: "Please enter a nick name",preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Re-enter", style: UIAlertAction.Style.default, handler: { _ in
            return
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func moreInfoMessageBox(){
        let alert = UIAlertController(title: "More Information", message: "You can enter a name, You can enter a name, You can enter a nameYou can enter a nameYou can enter a nameYou can enter a nameYou can enter a nameYou can enter a nameYou can enter a nameYou can enter a nameYou can enter a nameYou can enter a name",preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Re-enter", style: UIAlertAction.Style.default, handler: { _ in
            return
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

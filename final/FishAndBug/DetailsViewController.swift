//
//  DetailsViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/17.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //Basic property: name, location, time, and image
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timedayLabel: UILabel!
    @IBOutlet weak var fbImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    //Month bool check
    @IBOutlet weak var januaryLabel: UILabel!
    @IBOutlet weak var februaryLabel: UILabel!
    @IBOutlet weak var marchLabel: UILabel!
    @IBOutlet weak var aprilLabel: UILabel!
    @IBOutlet weak var mayLabel: UILabel!
    @IBOutlet weak var juneLabel: UILabel!
    @IBOutlet weak var julyLabel: UILabel!
    @IBOutlet weak var augustLabel: UILabel!
    @IBOutlet weak var spetemberLabel: UILabel!
    @IBOutlet weak var octoberLabel: UILabel!
    @IBOutlet weak var novemberLabel: UILabel!
    @IBOutlet weak var decemberLabel: UILabel!
    
    @IBAction func northsouthSegmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedIndex = 1
            resetLabel()
            northloading()
        }
        else {
            selectedIndex = 2
            resetLabel()
            southload()
        }
    }
    
    // Fish data from search UI screen
    var detailFish: FishData?
    // Fish data from myList screen
    var myListFish: Fish?
    var detailBug: BugData?
    var selectedIndex = 1
    //Bool to check whether Fish? OR Bug?
    var isFish: Bool?
    //Bool to check whether should disable the Add to List button
    var isHidden = false
    weak var databaseController: DatabaseProtocol?
    @IBAction func addTomyList(_ sender: Any) {
        
        if(isFish == true){
        
        let addedFish = databaseController?.addFish(name: detailFish!.name, location: detailFish!.location, imageURL: detailFish!.imageURL, timeday: detailFish!.timeday, price: detailFish!.price)
            addedFish?.fishNorth = databaseController?.addNorth(jan: detailFish!.north[0], feb: detailFish!.north[1], mar: detailFish!.north[2], apr: detailFish!.north[3], may: detailFish!.north[4], jun: detailFish!.north[5], jul: detailFish!.north[6], aug: detailFish!.north[7], spe: detailFish!.north[8], oct: detailFish!.north[9], nov: detailFish!.north[10], dec: detailFish!.north[11])
            addedFish?.fishSouth = databaseController?.addSouth(jan: detailFish!.south[0], feb: detailFish!.south[1], mar: detailFish!.south[2], apr: detailFish!.south[3], may: detailFish!.south[4], jun: detailFish!.south[5], jul: detailFish!.south[6], aug: detailFish!.south[7], spe: detailFish!.south[8], oct: detailFish!.south[9], nov: detailFish!.south[10], dec: detailFish!.south[11])
            showMessageBox()
        }
        else{
            
            let addedBug = databaseController?.addBug(name: detailBug!.name, location: detailBug!.location, imageURL: detailBug!.imageURL, timeday: detailBug!.timeday, price: detailBug!.price)
            addedBug?.bugNorth = databaseController?.addNorth(jan: detailBug!.north[0], feb: detailBug!.north[1], mar: detailBug!.north[2], apr: detailBug!.north[3], may: detailBug!.north[4], jun: detailBug!.north[5], jul: detailBug!.north[6], aug: detailBug!.north[7], spe: detailBug!.north[8], oct: detailBug!.north[9], nov: detailBug!.north[10], dec: detailBug!.north[11])
            addedBug?.bugSouth = databaseController?.addSouth(jan: detailBug!.south[0], feb: detailBug!.south[1], mar: detailBug!.south[2], apr: detailBug!.south[3], may: detailBug!.south[4], jun: detailBug!.south[5], jul: detailBug!.south[6], aug: detailBug!.south[7], spe: detailBug!.south[8], oct: detailBug!.south[9], nov: detailBug!.south[10], dec: detailBug!.south[11])
            showMessageBox()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        // Do any additional setup after loading the view.
        checkFishandBug()
        northloading()
    }
    //MARK: -North load
    func northloading(){
        if(isFish == true){
            if(detailFish?.north[0] == true){
                januaryLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[1] == true){
                februaryLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[2] == true){
                marchLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[3] == true){
                aprilLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[4] == true){
                mayLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[5] == true){
                juneLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[6] == true){
                julyLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[7] == true){
                augustLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[8] == true){
                spetemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[9] == true){
                octoberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[10] == true){
                novemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.north[11] == true){
                decemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
        }
        if(isFish == false){
            if(detailBug?.north[0] == true){
                januaryLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[1] == true){
                februaryLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[2] == true){
                marchLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[3] == true){
                aprilLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[4] == true){
                mayLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[5] == true){
                juneLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[6] == true){
                julyLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[7] == true){
                augustLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[8] == true){
                spetemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[9] == true){
                octoberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[10] == true){
                novemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.north[11] == true){
                decemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
        }
    }
    
    //MARK: -South Load
    func southload(){
        if (isFish == true){
            if(detailFish?.south[0] == true){
                januaryLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[1] == true){
                februaryLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[2] == true){
                marchLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[3] == true){
                aprilLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[4] == true){
                mayLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[5] == true){
                juneLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[6] == true){
                julyLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[7] == true){
                augustLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[8] == true){
                spetemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[9] == true){
                octoberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[10] == true){
                novemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailFish?.south[11] == true){
                decemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }}
        
        if (isFish == false){
            if(detailBug?.south[0] == true){
                januaryLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[1] == true){
                februaryLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[2] == true){
                marchLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[3] == true){
                aprilLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[4] == true){
                mayLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[5] == true){
                juneLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[6] == true){
                julyLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[7] == true){
                augustLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[8] == true){
                spetemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[9] == true){
                octoberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[10] == true){
                novemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }
            if(detailBug?.south[11] == true){
                decemberLabel.backgroundColor = UIColor(red: 25/255, green: 202/255, blue: 173/255, alpha: 1.0)
            }}
    }
    
    //MARK: -Defalut Load
    func resetLabel(){
        januaryLabel.backgroundColor = UIColor.systemGray2
        februaryLabel.backgroundColor = UIColor.systemGray2
        marchLabel.backgroundColor = UIColor.systemGray2
        aprilLabel.backgroundColor = UIColor.systemGray2
        mayLabel.backgroundColor = UIColor.systemGray2
        juneLabel.backgroundColor = UIColor.systemGray2
        julyLabel.backgroundColor = UIColor.systemGray2
        augustLabel.backgroundColor = UIColor.systemGray2
        spetemberLabel.backgroundColor = UIColor.systemGray2
        octoberLabel.backgroundColor = UIColor.systemGray2
        novemberLabel.backgroundColor = UIColor.systemGray2
        decemberLabel.backgroundColor = UIColor.systemGray2
    }

    //MARK: - SET Image
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.fbImage.image = image
            }
        }
    }
    
    //MARK: - Fish/ Bug jugement
    func checkFishandBug(){
        if (isFish == true) {
            nameLabel.text = detailFish?.name
            locationLabel.text = detailFish?.location
            timedayLabel.text = detailFish?.timeday
            let price = detailFish?.price
            priceLabel.text = String(price!)
            setImage(from: detailFish!.imageURL)
        }
        if (isFish == false){
            nameLabel.text = detailBug?.name
            locationLabel.text = detailBug?.location
            timedayLabel.text = detailBug?.timeday
            let price = detailBug?.price
            priceLabel.text = String(price!)
            setImage(from: detailBug!.imageURL)
        }
    }
    
    //MARK: -Message Window Box
    func showMessageBox(){
        let alert = UIAlertController(title: "Added", message: "Add Sucessfully, you can go my List to review your addition",preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Go back", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

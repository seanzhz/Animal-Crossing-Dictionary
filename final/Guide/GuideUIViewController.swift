//
//  GuideUIViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/16.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class GuideUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var goldenGuide = [GoldenClass]()
    var islandGuide = [IslandClass]()
    
    
    let array3 = ["genreal1", "general2", "gerenal3"]
    //segmented control set up
    var selectedIndex = 1
    //
    
    @IBOutlet weak var guideTableView: UITableView!
    @IBAction func guideSegmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            selectedIndex = 1
        }
        else if sender.selectedSegmentIndex == 1{
            selectedIndex = 2
        }
        else{
            selectedIndex = 3
        }
        self.guideTableView.reloadData()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        defalutGolden()
        defalutIsland()

        // Do any additional setup after loading the view.
        self.guideTableView.delegate = self
        self.guideTableView.dataSource = self
    }
    

    
    
    //MARK: - Table view
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 1{
            return goldenGuide.count
        }
        else if selectedIndex == 2 {
            return islandGuide.count
        }
        else {
            return array3.count
        }
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if selectedIndex == 1{
            let cell1 = guideTableView.dequeueReusableCell(withIdentifier: "goldenCell")! as! GoldenTableViewCell
            //let reSize = CGSize(width: 40, height: 40)
            cell1.nameLabel.text = goldenGuide[indexPath.row].title
            cell1.contentLabel.text = goldenGuide[indexPath.row].content
            cell1.imagePath.image = UIImage(named: goldenGuide[indexPath.row].imagePath!)
            return cell1
        }
        else if selectedIndex == 2 {
            let cell1 = guideTableView.dequeueReusableCell(withIdentifier: "islandCell")! as! GuideTableViewCell
            cell1.nameLabel.text = islandGuide[indexPath.row].name
            cell1.introLabel.text = islandGuide[indexPath.row].intro
            return cell1
        }
        else {
            let cell1 = guideTableView.dequeueReusableCell(withIdentifier: "islandCell")! as! GuideTableViewCell
            cell1.nameLabel.text = array3[indexPath.row]
            return cell1
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

     // MARK: - Creation of defalut
    func defalutGolden(){
        let goldenAxe = GoldenClass(title: "Golden Axe", content: "The DIY Recipe for the Golden Axe is unlocked after breaking 100 axes.", imagePath: "Golden Axe.png")
        let goldenCan = GoldenClass(title: "Golden Watering Can", content: "The DIY Recipe for the Golden Watering Can is unlocked after attaining a 5-star town rating.", imagePath: "Golden Watering Can.png")
        let goldenShovel = GoldenClass(title: "Golden Shovel", content: "The DIY Recipe for the Golden Shovel is unlocked after assisting Gulliver 30 times.", imagePath: "Golden Shovel.png")
        let goldenNet = GoldenClass(title: "Golden Net", content: "The DIY Recipe for the Golden Net is unlocked after completing the bug section of the Critterpedia.", imagePath: "Golden Net.png")
        let goldenFishRod = GoldenClass(title: "Golden Fishing Rod", content: "The DIY Recipe for the Golden Fishing Rod is unlocked after completing the fish section of the Critterpedia.", imagePath: "Golden Fishing Rod.png")
        let goldenSlingshot = GoldenClass(title: "Golden Slingshot", content: "The DIY Recipe for the Golden Slingshot is unlocked after shooting 300 balloons.", imagePath: "Golden Slingshot.png")
        goldenGuide.append(goldenAxe)
        goldenGuide.append(goldenCan)
        goldenGuide.append(goldenNet)
        goldenGuide.append(goldenShovel)
        goldenGuide.append(goldenFishRod)
        goldenGuide.append(goldenSlingshot)
        
    }
    
    func defalutIsland(){
        let island1 = IslandClass(name: "Standard Islands", intro: "These islands will have your native fruit, your native flower, a normal assortment of trees, and a basic river with no apparent difference in the type or frequency of bug and fish spawns. There will be a few rocks, all of which contain resources (no money rocks, in other words), and one tree will have furniture in it. Many of these islands will also have one fossil, while the rarer islands usually don't.")
        let island2 = IslandClass(name: "Foreign Fruit Island", intro: "This one is slightly rarer. It is otherwise a normal island, except all the trees are fruit trees--and it's a different fruit than the one native to your island! You can pick the fruit and take it home to sell or plant (we recommend planting it first). ")
        let island3 = IslandClass(name: "Bamboo Island", intro: "Somewhat common, the bamboo island only has bamboo on it--no rivers or ponds, though it does have rocks, coconut trees, and sometimes fossils. You can dig up bamboo shoots and plant them on your island, or you can eat some coconuts and dig up the bamboo trees whole.")
        let island4 = IslandClass(name: "Hybrid Flower Island", intro: "Even more rare is an island covered in hybrid flowers--pink, black, orange, purple, or blue flowers whose seeds you can't buy from Timmy and Tommy. They'll usually be accompanied by butterflies, many of which only spawn around these rare hybrid flowers.")
        let island5 = IslandClass(name: "Money Rock Island", intro: "If you ever find an island where there's a group of rocks in the center, surrounded by a river, then you have hit the jackpot. Those rocks are all money rocks, just like the one rock that spawns every day on the main island.")
        let island6 = IslandClass(name: "Tarantula Island", intro: "An island to fuel your nightmares, the tarantula island is inhabited by a seemingly infinite number of tarantulas. They sell for 8,000 bells each, so catch as many as you can carry. This is absolutely one of the jackpot islands, even if it's a little creepy. ")
        let island7 = IslandClass(name: "Scorpion Island", intro: "Similar to the tarantula island, the scorpion island is covered in, well, scorpions. They also sell for 8,000 bells each (or 12,000 to Flick), so you should catch as many as you can carry if you're lucky enough to get this rare island. ")
        let island8 = IslandClass(name: "Trash Island", intro: "This island appears normal and consists of regular trees and flowers like every other island; the catch is that the river, lake, and ocean are full of trash. Fishing on this island will only yield trash items (cans, tires, and boots). ")
        islandGuide.append(island1)
        islandGuide.append(island2)
        islandGuide.append(island3)
        islandGuide.append(island4)
        islandGuide.append(island5)
        islandGuide.append(island6)
        islandGuide.append(island7)
        islandGuide.append(island8)
       
    }
    
}

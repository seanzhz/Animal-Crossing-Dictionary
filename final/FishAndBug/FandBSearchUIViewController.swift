//
//  FandBSearchUIViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/16.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit


class FandBSearchUIViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    
    
    @IBAction func fishbugSegmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedIndex = 1
        }
        else {
            selectedIndex = 2}
        
        self.fIshtb.reloadData()
    }
    @IBOutlet weak var fIshtb: UITableView!
    
    var searchedFish = [FishData]()
    var searchedBug = [BugData]()
    var filterFish = [FishData]()
    var filterBug = [BugData]()
    var selectedIndex = 1
    let CELL_FISH = "FishCell"
    let CELL_BUG = "BugCell"
    let requestFishURL = "https://raw.githubusercontent.com/seanzhz/Animal-Crossing-Json/master/Fish.json"
    let requestBugURL = "https://raw.githubusercontent.com/seanzhz/Animal-Crossing-Json/master/Bug.json"
    var indicator = UIActivityIndicatorView()
   

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.requestCocktails()
        self.requestBug()
        self.fIshtb.delegate = self
        self.fIshtb.dataSource = self

        // Do any additional setup after loading the view.
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter your query..."
        navigationItem.searchController = searchController
        // Make sure search bar is always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
        // This view controller decides how the search controller is presented
        definesPresentationContext = true
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Create a loading animation
        indicator.style = UIActivityIndicatorView.Style.medium
        //indicator.center = self.tableView.center
        self.view.addSubview(indicator)
    }
    
    
    //MARK: - Research
    func requestCocktails(){
        let jsonURL =
            URL(string: requestFishURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        let task = URLSession.shared.dataTask(with: jsonURL!)
        { (data, response, error) in
            // Regardless of response end the loading icon from the main thread
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
            if let error = error {
                print(error)
                return
            }
            //Deal with the data
            do {
                let decoder = JSONDecoder()
                let volumeData = try decoder.decode([FishData].self, from: data!)
                self.searchedFish.append(contentsOf: volumeData)
                self.filterFish = self.searchedFish
                DispatchQueue.main.async {
                    self.fIshtb.reloadData()
                }
                
            } catch let err {
                print(err) }
        }
        task.resume()
    }
    
    func requestBug(){
        let jsonURL =
            URL(string: requestBugURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        let task = URLSession.shared.dataTask(with: jsonURL!)
        { (data, response, error) in
            // Regardless of response end the loading icon from the main thread
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
            if let error = error {
                print(error)
                return
            }
            //Deal with the data
            do {
                let decoder = JSONDecoder()
                let volumeData = try decoder.decode([BugData].self, from: data!)
                self.searchedBug.append(contentsOf: volumeData)
                self.filterBug = self.searchedBug
                DispatchQueue.main.async {
                    self.fIshtb.reloadData()
                }
            } catch let err {
                print(err) }
        }
        task.resume()
    }
    
    //MARK: -Filter Bug and Fish
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            return
        }
        
        if searchText.count > 0 && selectedIndex == 1{
            filterFish = searchedFish.filter({ (fish: FishData) -> Bool in
                return fish.name.lowercased().contains(searchText)
            })
        }
        else {
            filterFish = searchedFish
        }
       
        
        if searchText.count > 0 && selectedIndex == 2{
            filterBug = searchedBug.filter({ (bug: BugData) -> Bool in
                return bug.name.lowercased().contains(searchText)
            })
        }
        else {
            filterBug = searchedBug
        }
        self.fIshtb.reloadData()
    }
    
    
    //MARK: -DATA SOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 1{
            return filterFish.count
        }
        else {
            return filterBug.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (selectedIndex == 1){
            let cell1 = fIshtb.dequeueReusableCell(withIdentifier: CELL_FISH)! as! FishBugTableViewCell
            let fish = filterFish[indexPath.row]
            cell1.nameLabel.text = fish.name
            cell1.locationLabel.text = fish.location
            cell1.timeLabel.text = fish.timeday
            cell1.priceLabel.text = String(fish.price)
            //setImage(from: fish.imageURL)
            DispatchQueue.global().async {
                guard let imageURL = URL(string: fish.imageURL) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell1.imageURL.image = image
                    
                    //cell1.imageURL.
                }
            }
            return cell1
        }
            
        else{
            let cell1 = fIshtb.dequeueReusableCell(withIdentifier: CELL_BUG)! as! FishBugTableViewCell
            let bug = filterBug[indexPath.row]
            cell1.nameLabel.text = bug.name
            cell1.locationLabel.text = bug.location
            cell1.timeLabel.text = bug.timeday
            cell1.priceLabel.text = String(bug.price)
            DispatchQueue.global().async {
                guard let imageURL = URL(string: bug.imageURL) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell1.imageURL.image = image
                }
            }
            return cell1
        }
    }
    
    //MARK: -IMAGHE
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "FishDisplayDetail" {
            let destination = segue.destination as! DetailsViewController
            let sentFish = filterFish[fIshtb.indexPathForSelectedRow!.row]
            destination.detailFish = sentFish
            destination.isFish = true
            print("Name: \(sentFish.name), Location: \(sentFish.location), timeday: \(sentFish.timeday), north:\(sentFish.north), south: \(sentFish.south)")
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        if segue.identifier == "BugDisplayDetail"{
            let destination = segue.destination as! DetailsViewController
            let sentBug = filterBug[fIshtb.indexPathForSelectedRow!.row]
            destination.detailBug = sentBug
            destination.isFish = false
            print("Name: \(sentBug.name), Location: \(sentBug.location), timeday: \(sentBug.timeday), north:\(sentBug.north), south: \(sentBug.south)")
        }
        
    }
}


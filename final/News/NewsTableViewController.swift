//
//  NewsTableViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/9.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var searchedNews = [NewsData]()
    var indicator = UIActivityIndicatorView()
    let CELL_NEWS = "newsCell"
    let requestNewsURL = "https://raw.githubusercontent.com/seanzhz/Animal-Crossing-Json/master/News.json"
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNews()
        
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.tableView.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.clear
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func reFreshBtn(_ sender: Any) {
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.clear
        //print(searchedNews.count)
        searchedNews.removeAll()
        //print(searchedNews.count)
        tableView.reloadData()
        requestNews()
        //tableView.reloadData()
        print(searchedNews.count)
       
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchedNews.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: CELL_NEWS)! as! NewsTableViewCell
        let news = searchedNews[indexPath.row]
        cell1.titleLabel.text = news.title
        cell1.authorLabel.text = news.author
        cell1.publishDateLabel.text = news.publishDate
        cell1.resourceFromLabel.text = news.resource
        DispatchQueue.global().async {
            guard let imageURL = URL(string: news.imageURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                cell1.newsImage.image = image
                
                //cell1.imageURL.
            }
        }
        return cell1
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "loadNewsSegue" {
            let destination = segue.destination as! NewsViewController
            let sentNews = searchedNews[tableView.indexPathForSelectedRow!.row]
            destination.news = sentNews
        }
    }
    
    
    func requestNews(){
        let jsonURL =
            URL(string: requestNewsURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
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
                let volumeData = try decoder.decode([NewsData].self, from: data!)
                self.searchedNews.append(contentsOf: volumeData)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let err {
                print(err) }
        }
        task.resume()
    }
    
}

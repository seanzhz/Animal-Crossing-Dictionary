//
//  NewsViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/9.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {
    
    var news: NewsData?
    var newtitle: String?
    var newsubtitle: String?
    var authorname: String?
    var rescource: String?
    var publishDate: String?
    var summaryOutput: String?
    
    @IBOutlet weak var mynews: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let news = news else {
            return
        }
        let reacr = CGRect(x: 0, y: 20, width: 420, height: 568)
        let webView = WKWebView(frame: reacr)
        let myURL = (news.contentURL)
        let url = URL(string: myURL)
        let request = URLRequest(url: url!)
        mynews.load(request)
        
        //load news summay
        newtitle = "Title: \(news.title)"
        newsubtitle = "Sub-title: \(news.subtitle)"
        authorname = "Author: \(news.author)"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showSummary(_ sender: Any) {
        moreInfoMessageBox()
    }
    
    func moreInfoMessageBox(){
            let alert = UIAlertController(title: "Summary", message: "\(newtitle!)\n\(newsubtitle!)\n\(authorname!)",preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Re-enter", style: UIAlertAction.Style.default, handler: { _ in
                return
                
            }))
            self.present(alert, animated: true, completion: nil)
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



//
//  StalkViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/4.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import WebKit

class StalkViewController: UIViewController {

    @IBOutlet weak var mynew: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reacr = CGRect(x: 0, y: 20, width: 420, height: 568)
        let webView = WKWebView(frame: reacr)
        
        let url = URL(string: "https://turnipprophet.io/")
        let request = URLRequest(url: url!)
        mynew.load(request)
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}

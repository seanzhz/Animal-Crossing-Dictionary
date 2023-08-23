//
//  VideoViewController.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/21.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVPlayerViewControllerDelegate {
    
    //Link with UI element
    @IBOutlet weak var videoTableView: UITableView!
    
    
    //create my video list
    var videoList = [Video]()
    var playController = AVPlayerViewController()
    let VIDEO_CELL = "videoCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoTableView.delegate = self
        self.videoTableView.dataSource = self
        createVideo()
        

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoCell = videoTableView.dequeueReusableCell(withIdentifier: VIDEO_CELL)! as! VideoTableViewCell
        videoCell.videoTitle.text = videoList[indexPath.row].title
        videoCell.videoImage.image = UIImage(named: videoList[indexPath.row].imageURL!)
        return videoCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let videoURL = Bundle.main.url(forResource: videoList[indexPath.row].sourceURL, withExtension: "mp4") else{
            print("could not load video")
            return
        }
        let player = AVPlayer(url: videoURL)
        playController = AVPlayerViewController()
        playController.player = player
        playController.allowsPictureInPicturePlayback = true
        playController.delegate = self
        playController.player?.play()
        self.present(playController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: - Create Video list
    
    func createVideo(){
        videoList.append(Video(title: "14 Things To Do Daily", imageURL: "video-14things.jpg", onlineCheck: false,
                               sourceURL: "14things", type: "Local"))
    }

}

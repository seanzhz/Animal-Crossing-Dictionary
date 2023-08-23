//
//  FishBugTableViewCell.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/17.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class FishBugTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var imageURL: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

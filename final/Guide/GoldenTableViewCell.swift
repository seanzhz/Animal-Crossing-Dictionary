//
//  GoldenTableViewCell.swift
//  final
//
//  Created by 朱泓撰 on 2020/6/6.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit

class GoldenTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imagePath: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

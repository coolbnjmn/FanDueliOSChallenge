//
//  PickMatchTableViewCell.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/15/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit
import SDWebImage

class PickMatchTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    var leftPlayer: Player? {
        didSet {
            if let leftPlayer = leftPlayer {
                leftImageView.sd_setImageWithURL(leftPlayer.playerImages?.first)
            }
        }
    }
    
    var rightPlayer: Player? {
        didSet {
            if let rightPlayer = rightPlayer {
                rightImageView.sd_setImageWithURL(rightPlayer.playerImages?.first)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}

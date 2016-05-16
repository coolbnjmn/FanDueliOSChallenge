//
//  PickMatchTableViewCell.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/15/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit
import SDWebImage

protocol PickMatchTableViewCellDelegate {
    func rightTapped(playerId: String?)
    func leftTapped(playerId: String?)
}
class PickMatchTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftNameLabel: UILabel!
    @IBOutlet weak var rightNameLabel: UILabel!
    @IBOutlet weak var leftLastNameLabel: UILabel!
    @IBOutlet weak var rightLastNameLabel: UILabel!
    
    var leftPlayer: Player? {
        didSet {
            if let leftPlayer = leftPlayer {
                leftImageView.sd_setImageWithURL(leftPlayer.playerImages?.first)
                leftNameLabel.text = leftPlayer.firstName
                leftLastNameLabel.text = leftPlayer.lastName
            }
        }
    }
    
    var rightPlayer: Player? {
        didSet {
            if let rightPlayer = rightPlayer {
                rightImageView.sd_setImageWithURL(rightPlayer.playerImages?.first)
                rightNameLabel.text = rightPlayer.firstName
                rightLastNameLabel.text = rightPlayer.lastName
            }
        }
    }
    
    var delegate: PickMatchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let leftImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PickMatchTableViewCell.leftImageTapped(_:)))
        
        let rightImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PickMatchTableViewCell.rightImageTapped(_:)))
        
        leftImageView.addGestureRecognizer(leftImageTapGestureRecognizer)
        rightImageView.addGestureRecognizer(rightImageTapGestureRecognizer)
    }
    
    func leftImageTapped(sender: AnyObject) {
        delegate?.leftTapped(leftPlayer?.playerId)
    }
    
    func rightImageTapped(sender: AnyObject) {
        delegate?.rightTapped(rightPlayer?.playerId)
    }
}

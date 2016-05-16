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
    
    @IBOutlet weak var leftFPPGLabel: UILabel!
    @IBOutlet weak var rightFPPGLabel: UILabel!
    
    var leftPlayer: Player? {
        didSet {
            if let leftPlayer = leftPlayer {
                leftImageView.sd_setImageWithURL(leftPlayer.playerImages?.first)
                leftNameLabel.text = leftPlayer.firstName
                leftLastNameLabel.text = leftPlayer.lastName
                leftFPPGLabel.text = (viewModel?.isRevealed ?? false ? "\(leftPlayer.fPPG)" : "")
            }
        }
    }
    
    var rightPlayer: Player? {
        didSet {
            if let rightPlayer = rightPlayer {
                rightImageView.sd_setImageWithURL(rightPlayer.playerImages?.first)
                rightNameLabel.text = rightPlayer.firstName
                rightLastNameLabel.text = rightPlayer.lastName
                rightFPPGLabel.text = (viewModel?.isRevealed ?? false ? "\(rightPlayer.fPPG)" : "")
            }
        }
    }
    
    var delegate: PickMatchTableViewCellDelegate?
    var viewModel: PickMatchCellViewModel? {
        didSet {
            rightPlayer = viewModel?.rightPlayer
            leftPlayer = viewModel?.leftPlayer
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let leftImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PickMatchTableViewCell.leftImageTapped(_:)))
        
        let rightImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PickMatchTableViewCell.rightImageTapped(_:)))
        
        leftImageView.addGestureRecognizer(leftImageTapGestureRecognizer)
        rightImageView.addGestureRecognizer(rightImageTapGestureRecognizer)
    }
    
    func leftImageTapped(sender: AnyObject) {
        delegate?.leftTapped(leftPlayer?.playerId)
        leftImageView.userInteractionEnabled = false
        rightImageView.userInteractionEnabled = false
        revealFPPG()
    }
    
    func rightImageTapped(sender: AnyObject) {
        delegate?.rightTapped(rightPlayer?.playerId)
        leftImageView.userInteractionEnabled = false
        rightImageView.userInteractionEnabled = false
        revealFPPG()
    }
    
    func revealFPPG() {
        if let leftPlayer = leftPlayer {
            leftFPPGLabel.text = "\(leftPlayer.fPPG)"
        }
        
        if let rightPlayer = rightPlayer {
            rightFPPGLabel.text = "\(rightPlayer.fPPG)"
        }
        
        viewModel?.isRevealed = true
    }
}

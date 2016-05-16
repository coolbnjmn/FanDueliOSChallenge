//
//  PickMatchTableViewCell.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/15/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit
import SDWebImage

enum Pick {
    case Left
    case Right
}
protocol PickMatchTableViewCellDelegate {
    func rightTapped(viewModel: PickMatchCellViewModel?)
    func leftTapped(viewModel: PickMatchCellViewModel?)
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
            
            if viewModel?.isRevealed ?? false {
                if viewModel?.didGuessCorrectly ?? false {
                    backgroundColor = UIColor.greenColor()
                } else {
                    backgroundColor = UIColor.redColor()
                }
                leftImageView.userInteractionEnabled = false
                rightImageView.userInteractionEnabled = false
            } else {
                leftImageView.userInteractionEnabled = true
                rightImageView.userInteractionEnabled = true
                backgroundColor = UIColor.clearColor()
            }
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
        leftImageView.userInteractionEnabled = false
        rightImageView.userInteractionEnabled = false
        revealFPPG(.Left)
        delegate?.leftTapped(viewModel)
    }
    
    func rightImageTapped(sender: AnyObject) {
        leftImageView.userInteractionEnabled = false
        rightImageView.userInteractionEnabled = false
        revealFPPG(.Right)
        delegate?.rightTapped(viewModel)
    }
    
    func revealFPPG(side: Pick) {
        if let leftPlayer = leftPlayer {
            leftFPPGLabel.text = "\(leftPlayer.fPPG)"
        }
        
        if let rightPlayer = rightPlayer {
            rightFPPGLabel.text = "\(rightPlayer.fPPG)"
        }
        
        viewModel?.isRevealed = true
        
        switch side {
        case .Left:
            viewModel?.didGuessCorrectly = rightPlayer?.fPPG < leftPlayer?.fPPG
        case .Right:
            viewModel?.didGuessCorrectly = leftPlayer?.fPPG < rightPlayer?.fPPG
        }
        
        if viewModel?.didGuessCorrectly ?? false {
            backgroundColor = UIColor.greenColor()
        } else {
            backgroundColor = UIColor.redColor()
        }
    }
}

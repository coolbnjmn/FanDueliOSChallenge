//
//  PickMatchCellViewModel.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/15/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit

public class PickMatchCellViewModel: NSObject {
    var rightPlayer: Player?
    var leftPlayer: Player?
    var isRevealed: Bool = false
    var didGuessCorrectly: Bool = false
    
    required public init(rightPlayer: Player, leftPlayer: Player) {
        self.rightPlayer = rightPlayer
        self.leftPlayer = leftPlayer
        super.init()
    }
}

//
//  Player.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/12/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit

class Player: NSObject {
    
    // Required fields
    var playerId: String
    var fPPG: Double
    var firstName: String
    var lastName: String
    
    // Optional Fields
    var team: String? // TODO: MAKE TEAM MODEL
    var salary: Double?
    var position: String?
    var playerCardUrl: NSURL?
    var playerImages: [String]?
    
    required init(id: String, firstName: String, lastName: String, fPPG: Double) {
        self.playerId = id
        self.firstName = firstName
        self.lastName = lastName
        self.fPPG = fPPG
        super.init()
    }
    
    convenience init(dictionary: [String: AnyObject]) {
        // Parse out JSON from dictionary into player model here. 
    }
}

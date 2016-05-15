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
    var firstName: String
    var lastName: String
    
    // Optional Fields
    var fPPG: Double = 0
    var teamId: String?
    var salary: Double?
    var position: String?
    var playerCardUrl: NSURL?
    var playerImages: [String]?
    
    required init(id: String, firstName: String, lastName: String) {
        self.playerId = id
        self.firstName = firstName
        self.lastName = lastName
        super.init()
    }
    
    convenience init(dictionary: [String: AnyObject]) {
        // Parse out JSON from dictionary into player model here. 
        guard let id = dictionary[Constants.PlayerConstants.JSONKeys.kID] as? String,
        firstName = dictionary[Constants.PlayerConstants.JSONKeys.kFirstName] as? String,
        lastName = dictionary[Constants.PlayerConstants.JSONKeys.kLastName] as? String else {
                assertionFailure("Failed to properly initialize a player object")
                self.init(id: "", firstName: "", lastName: "")
                return
        }
        
        self.init(id: id, firstName: firstName, lastName: lastName)
        
        if let fPPG = dictionary[Constants.PlayerConstants.JSONKeys.kFPPG] as? Double {
            self.fPPG = fPPG
        }
        if let teamId = dictionary[Constants.PlayerConstants.JSONKeys.kTeam] as? String {
            self.teamId = teamId
        }
        
        if let salary = dictionary[Constants.PlayerConstants.JSONKeys.kSalary] as? Double {
            self.salary = salary
        }
        
        if let position = dictionary[Constants.PlayerConstants.JSONKeys.kPosition] as? String {
            self.position = position
        }
        
        if let playerCardUrlString = dictionary[Constants.PlayerConstants.JSONKeys.kPlayerCardUrl] as? String,
            playerCardUrl = NSURL(string: playerCardUrlString) {
            self.playerCardUrl = playerCardUrl
        }
        
        if let playerImages = dictionary[Constants.PlayerConstants.JSONKeys.kImages] as? [String] {
            self.playerImages = playerImages
        }
    }
}

//
//  Team.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/15/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit

class Team: NSObject {

    // Required fields
    var teamId: String
    
    // Optional Fields
    var city: String?
    var code: String?
    var fullName: String?
    var name: String?
    
    
    required init(id: String) {
        self.teamId = id
        super.init()
    }
    
    convenience init(dictionary: [String: AnyObject]) {
        // Parse out JSON from dictionary into team model here.
        guard let id = dictionary[Constants.TeamConstants.JSONKeys.kID] as? String else {
            assertionFailure("Failed to properly initialize a player object")
                self.init(id: "")
                return
        }
        
        self.init(id: id)
        
        if let city = dictionary[Constants.TeamConstants.JSONKeys.kCity] as? String {
            self.city = city
        }
        
        if let code = dictionary[Constants.TeamConstants.JSONKeys.kCode] as? String {
            self.code = code
        }
        
        if let fullName = dictionary[Constants.TeamConstants.JSONKeys.kFullName] as? String {
            self.fullName = fullName
        }
        
        if let name = dictionary[Constants.TeamConstants.JSONKeys.kName] as? String {
            self.name = name
        }
    }
}

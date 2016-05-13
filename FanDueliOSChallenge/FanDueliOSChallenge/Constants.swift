//
//  Constants.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/12/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit

class Constants: NSObject {
 
    struct PlayerConstants {
        struct JSONKeys {
            static let kFirstName = "first_name" // String
            static let kLastName = "last_name" // String
            static let kNews = "news" // Dictionary
            static let kTeam = "team" // Dictionary
            static let kSalary = "salary" // Double
            static let kPosition = "position" // String
            static let kInjured = "injured" // Double
            static let kID = "id" // String
            static let kRemoved = "removed"  // Double
            static let kFPPG = "fppg" // Double
            static let kImages = "images" // Dictionary
            static let kPlayerCardUrl = "player_card_url" // URL
        }
    }
}

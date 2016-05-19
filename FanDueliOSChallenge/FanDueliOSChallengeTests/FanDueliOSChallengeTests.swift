//
//  FanDueliOSChallengeTests.swift
//  FanDueliOSChallengeTests
//
//  Created by Benjamin Hendricks on 5/12/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import XCTest
@testable import FanDueliOSChallenge

class FanDueliOSChallengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Unit test to check the creation of a player based on a given json file.
    func testPlayerCreation() {
        if let filePath = NSBundle.mainBundle().pathForResource("playerTest", ofType: "json"), data = NSData(contentsOfFile: filePath) {
            do {
                guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] else {
                    XCTAssertFalse(true)
                    return
                }
                let draymond = Player(dictionary: json)
                
                XCTAssert(draymond.firstName == "Draymond", "First name should be draymond")
                XCTAssert(draymond.lastName == "Green", "Last name should be green")
                XCTAssert(draymond.playerId == "15475-15860", "Player ID from API call")
            }
            catch {
                //Handle error
            }
        }
    }
    
    // Unit test to check creation of a team based on given json file. 
    func testTeamCreation() {
        if let filePath = NSBundle.mainBundle().pathForResource("teamTest", ofType: "json"), data = NSData(contentsOfFile: filePath) {
            do {
                guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] else {
                    XCTAssertFalse(true)
                    return
                }
                let goldenState = Team(dictionary: json)
                
                XCTAssert(goldenState.name == "Warriors", "Team name should be warriors.")
                XCTAssert(goldenState.teamId == "687", "Team ID from API call")
            }
            catch {
                //Handle error
            }
        }
    }
}

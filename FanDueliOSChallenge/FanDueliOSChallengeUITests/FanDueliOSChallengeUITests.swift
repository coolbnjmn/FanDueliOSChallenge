//
//  FanDueliOSChallengeUITests.swift
//  FanDueliOSChallengeUITests
//
//  Created by Benjamin Hendricks on 5/12/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import XCTest

class FanDueliOSChallengeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     This test is simple -- keep tapping on the left hand side picture until you win. Reset if necessary, but always press left and check for win state.
     To check for win, we look for the alert that comes up on a win. 
     */
    func testFullGameFlow() {
        let tablesQuery = XCUIApplication().tables
        var cellIndex: UInt = 0
        
        while( XCUIApplication().alerts.count == 0 ) {
            let cell = tablesQuery.cells.elementBoundByIndex(cellIndex)
            cell.childrenMatchingType(.Image).elementBoundByIndex(0).tap()
            cellIndex += 1
            
            if cellIndex > tablesQuery.cells.count {
               XCUIApplication().navigationBars.buttons.elementBoundByIndex(0).tap()
                cellIndex = 0
            }
        }
        
        XCTAssert(XCUIApplication().alerts.elementBoundByIndex(0).label == "You won!", "Check title of alert")
        
    }
    
}

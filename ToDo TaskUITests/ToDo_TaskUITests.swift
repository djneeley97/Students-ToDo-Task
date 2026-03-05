//
//  ToDo_TaskUITests.swift
//  ToDo TaskUITests
//
//  Created by Gabriela Sanchez on 09/12/25.
//

import XCTest

final class ToDo_TaskUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()

        
    }

    @MainActor
    func testLaunchPerformance() throws {
        
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testTaskHasDateVisible() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["ProfileCard_Professor"].tap()
        app.buttons["GroupLink_Groceries"].tap()
        
        let dateDisplay = app.staticTexts["TaskDateLabel"]
        
        XCTAssertTrue(dateDisplay.exists, "the task date should be displayed")
    }
    
    func testTaskPriority() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["ProfileCard_Professor"].tap()
        app.buttons["GroupLink_Groceries"].tap()
        
        let priorityFilter = app.staticTexts["Priority_picker"]
        
        XCTAssertTrue(priorityFilter.exists, "Priority should be displayed")
    }
}

//
//  RadioGroupDemoUITests.swift
//  RadioGroupDemoUITests
//
//  Created by Yonat Sharon on 05.02.2019.
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

import XCTest

class RadioGroupDemoUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testExample() {
        let app = XCUIApplication()
        let radioGroup = app.otherElements["RadioGroup"]
//        print("\n\n=== radioGroup ===\n", radioGroup.debugDescription, "\n\n\n")

        let options = radioGroup.otherElements.matching(identifier: "RadioGroupItem")
        let firstOption = options.element(boundBy: 0)
        let secondOption = options.element(boundBy: 1)
//        print("\n\n=== firstOption ===\n", firstOption.debugDescription, "\n\n\n")

        XCTAssertFalse(firstOption.isSelected)
        firstOption.tap()
        XCTAssertTrue(firstOption.isSelected)

        XCTAssertFalse(secondOption.isSelected)
        secondOption.tap()
        XCTAssertTrue(secondOption.isSelected)
        XCTAssertFalse(firstOption.isSelected)
    }
}

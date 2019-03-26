//
//  SwiftTestDemoTests.swift
//  SwiftTestDemoTests
//
//  Created by user on 2019/3/22.
//  Copyright © 2019 adu. All rights reserved.
//

import XCTest
@testable import SwiftTestDemo

class SwiftTestDemoTests: XCTestCase {

    func testMealInitialization () {
        //success test
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        //failure test
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        //bad rating
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
        
    }

}

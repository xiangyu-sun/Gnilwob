//
//  IntegrationTests.swift
//  BowlingureTests
//
//  Created by 孙翔宇 on 4/22/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import XCTest
@testable import Bowlingure

class IntegrationTests: XCTestCase {
    var scorer: Scorer!
    override func setUp() {
        scorer = Scorer()
    }

    func testSample() {
        XCTAssertEqual(scorer.rolledWith(pinsKnockedDownSequence: [9 ,1, 0, 10, 10, 10, 6, 2, 7, 3, 8, 2, 10, 9, 0, 10]), [10, 30, 48, 56, 74, 94, 113, 122])
    }
}

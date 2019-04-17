//
//  FrameTests.swift
//  BowlingureTests
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import XCTest
@testable import Bowlingure


class FrameTests: XCTestCase {
    var frame: Frame!
    
    override func setUp() {
        frame = Frame()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGameMaximumBallsPerFrame() {
       XCTAssertEqual(Frame.maximumBallCount, 2)
    }
    
    func testMaximumPinCountPerFrame() {
       XCTAssertEqual(Frame.maxiumPinsCount, 10)
    }
    
    func testNewFrame() {
        XCTAssertNil(frame.state)
    }
    
    func testStrike() {
       XCTAssertTrue(frame.state is StrikeState)
    }
    
    func testSpare() {
       XCTAssertTrue(frame.state is SpareState)
    }
    
    func testMissed() {
       XCTAssertTrue(frame.state is MissedState)
    }
    

}

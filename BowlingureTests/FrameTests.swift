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
        frame.addPinsKnockedDown(10)
        XCTAssertTrue(frame.state is StrikeState)
    }
    
    func testSpare() {
        frame.addPinsKnockedDown(3)
        frame.addPinsKnockedDown(7)
        XCTAssertTrue(frame.state is SpareState)
    }
    
    func testMissed() {
        frame.addPinsKnockedDown(2)
        frame.addPinsKnockedDown(3)
        XCTAssertTrue(frame.state is MissedState)
    }
    
    
}

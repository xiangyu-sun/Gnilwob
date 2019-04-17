//
//  ScorerTests.swift
//  BowlingureTests
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation
import XCTest
@testable import Bowlingure

class ScorerTests: XCTestCase {
    var scorer: Scorer!
    override func setUp() {
        scorer = Scorer()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testScoreOver() {
        XCTAssertTrue(scorer.gameIsOver)
    }
    
    func testScoreSofar() {
        XCTAssertTrue(scorer.scoreSoFar == "123")
    }
    
    func testFrameNumber() {
        XCTAssertTrue(scorer.frameNumber == "2")
    }
    
    func testFirstRoll() {
        let frameScore = scorer.rolledWith(pinsKnockedDown: 8)
        XCTAssertEqual(frameScore, [8])
    }
    
    func testRollBallOnGameoverSHouldTriggerANewGame() {
        XCTAssertTrue(scorer.frameNumber == "10")
        let scores1 = scorer.rolledWith(pinsKnockedDown: 8)
        XCTAssertEqual(scores1, [1,2,3,4,5])
        XCTAssertTrue(scorer.frameNumber == "1")
        let scores = scorer.rolledWith(pinsKnockedDown: 8)
        XCTAssertEqual(scores, [1])
        XCTAssertTrue(scorer.frameNumber == "2")
    }
    

}

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
    
    func testScoreOverWhentItsOver() {
        scorer.rolledWith(pinsKnockedDownSequence: [UInt].init(repeating: 10, count: 10))
        XCTAssertTrue(scorer.gameIsOver)
    }
    
    func testScoreOverWhentItsNotOver() {
        scorer.rolledWith(pinsKnockedDownSequence: [UInt].init(repeating: 10, count: 1))
        XCTAssertFalse(scorer.gameIsOver)
    }
    
    func testScoreSofar() {
        scorer.rolledWith(pinsKnockedDownSequence: [10, 2, 3, 8])
        XCTAssertEqual(scorer.scoreSoFar, "28")
    }
    
    func testFrameNumber() {
        scorer.rolledWith(pinsKnockedDown: 9)
        XCTAssertEqual(scorer.frameNumber, "1")
        scorer.rolledWith(pinsKnockedDown: 1)
        XCTAssertEqual(scorer.frameNumber, "2")
    }
    
    func testFirstRollShouldReturnEmptyScoreArray() {
        let frameScore = scorer.rolledWith(pinsKnockedDown: 8)
        XCTAssertEqual(frameScore, [])
    }
    
    func testFirstCompleteRollShouldReturnOneScoreArray() {
        let frameScore = scorer.rolledWith(pinsKnockedDownSequence: [10])
        XCTAssertEqual(frameScore, [10])
    }
    
    func testTwoCompleteRollShouldReturnTwoScoreArray() {
        let frameScore = scorer.rolledWith(pinsKnockedDownSequence: [10, 2, 8])
        XCTAssertEqual(frameScore, [20, 10])
    }
    
    func testRollBallOnGameoverSHouldTriggerANewGame() {
        let scores1 = scorer.rolledWith(pinsKnockedDownSequence: [UInt].init(repeating: 10, count: 10))
        XCTAssertEqual(scores1, [1,2,3,4,5])
        scorer.rolledWith(pinsKnockedDown: 8)
        XCTAssertEqual(scorer.frameNumber, "1")
    }
    

}

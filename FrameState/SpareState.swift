//
//  SpareState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

final class SpareState: CompleteFrameState {

    var ballsForScoring: [UInt]? {
        var frames = frame?.ballKnockedDownRecord
        if let firstBallOfNextFrame = frame?.getNextBallKnockedDownRecord(count: 1) {
            frames?.append(contentsOf: firstBallOfNextFrame)
        }
        return frames
    }
    
    var ballsRequiredForScoring: UInt {
        return 3
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        frame?.addBallKnockedDownRecord(count: count)
    }
}

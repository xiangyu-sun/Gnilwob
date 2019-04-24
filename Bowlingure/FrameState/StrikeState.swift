//
//  StrikeState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

final class StrikeState: FrameState {
    var maximumBallCount: UInt {
        return 2
    }
    
    var ballsForScoring: [UInt]? {
        var frames = frame?.ballKnockedDownRecord
        frames?.append(contentsOf: frame?.scoringFrame?.ballKnockedDownRecord ?? [])
        
        let ballsCount = frames?.count ?? 0
        if ballsCount < 3, let firstBallOfNextFrame = frame?.scoringFrame?.scoringFrame?.ballKnockedDownRecord.first {
            frames?.append(firstBallOfNextFrame)
        } else if ballsCount > 3 {
            frames?.removeLast()
        }
        return frames
    }
    
    var canBeScored: Bool {
        return ballsForScoring?.count == 3
    }
    
    var isFrameCompleted: Bool {
        return true
    }
    
    var calcualtedScore: UInt {
        return ballsForScoring?.sum() ?? 0
    }
    
    fileprivate weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        guard frame?.ballKnockedDownRecord.count == 0 else { return }
        frame?.addBallKnockedDownRecord(count: count)
    }
}

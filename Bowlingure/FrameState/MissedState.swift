//
//  MissedState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

final class MissedState: FrameState {
    var maximumBallCount: UInt {
        return 2
    }
    var ballsForScoring: [UInt]? {
        return frame?.ballKnockedDownRecord
    }
    
    var canBeScored: Bool {
        return ballsForScoring?.count == 2
    }
    
    var isFrameCompleted: Bool {
        return true
    }
    
    var calcualtedScore: UInt {
        return ballsForScoring?.sum() ?? 0
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        frame?.addBallKnockedDownRecord(count: count)
    }
}

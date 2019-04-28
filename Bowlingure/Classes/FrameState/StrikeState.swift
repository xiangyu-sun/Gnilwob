//
//  StrikeState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public final class StrikeState: CompleteFrameState {
    
    public var ballsForScoring: [UInt]? {
        guard let frame = frame else { return nil }
        
        var frames = frame.ballKnockedDownRecord
        
        let ballsMissing = ballsRequiredForScoring - frames.count
        if ballsMissing > 0 {
            frames.append(contentsOf: frame.getNextBallKnockedDownRecord(count: ballsMissing))
        }

        return frames
    }
    
    public var ballsRequiredForScoring: UInt {
        return 3
    }
    
    fileprivate weak var frame: Frame?
    
    public required init(_ frame: Frame) {
        self.frame = frame
    }
    
    public func addPinsKnockedDown(_ count: UInt) {
        guard frame?.ballKnockedDownRecord.count == 0 else { return }
        frame?.addBallKnockedDownRecord(count: count)
    }
}

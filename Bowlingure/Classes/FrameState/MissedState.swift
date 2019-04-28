//
//  MissedState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public final class MissedState: CompleteFrameState {

    public var ballsForScoring: [UInt]? {
        return frame?.ballKnockedDownRecord
    }
    
    private weak var frame: Frame?
    
    public required init(_ frame: Frame) {
        self.frame = frame
    }
    
    public func addPinsKnockedDown(_ count: UInt) {
        frame?.addBallKnockedDownRecord(count: count)
    }
}

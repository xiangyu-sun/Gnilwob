//
//  FirstBallRolledState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

final class FirstBallRolledState: FrameState {
    
    var maximumBallCount: UInt {
        return 2
    }
    
    var ballsForScoring: [UInt]? {
        return nil
    }
    
    var canBeScored: Bool {
        return false
    }
    
    var isFrameCompleted: Bool {
        return false
    }
    
    var calcualtedScore: UInt {
        return frame?.ballKnockedDownRecord.first ?? 0
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        if frame?.ballKnockedDownRecord.count == 0 {
            frame?.addBallKnockedDownRecord(count: count)
        } else if count == frame?.pinsLeft, let state: FrameState = frame?.lastFrame == true ? frame?.getFinalFrameSpareState() : frame?.getSpareState(){
            frame?.state = state
            frame?.state.addPinsKnockedDown(count)
        } else if let state: FrameState = frame?.getMissedState(){
            frame?.state = state
            frame?.state.addPinsKnockedDown(count)
        }
    }
}

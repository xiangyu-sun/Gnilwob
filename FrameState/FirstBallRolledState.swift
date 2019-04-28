//
//  FirstBallRolledState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

final class FirstBallRolledState: FrameState {
    
    var ballsForScoring: [UInt]? {
        return frame?.ballKnockedDownRecord
    }
    
    var isFrameCompleted: Bool {
        return false
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        if frame?.ballKnockedDownRecord.count == 0 {
            frame?.addBallKnockedDownRecord(count: count)
        } else if count == frame?.pinsLeft, let state = frame?.getSpareState(){
            frame?.state = state
            frame?.state.addPinsKnockedDown(count)
        } else if let state: FrameState = frame?.getMissedState(){
            frame?.state = state
            frame?.state.addPinsKnockedDown(count)
        }
    }
}

//
//  MissedState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

final class MissedState: CompleteFrameState {

    var ballsForScoring: [UInt]? {
        return frame?.ballKnockedDownRecord
    }
    
    var canBeScored: Bool {
        return ballsForScoring?.count == 2
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        frame?.addBallKnockedDownRecord(count: count)
    }
}

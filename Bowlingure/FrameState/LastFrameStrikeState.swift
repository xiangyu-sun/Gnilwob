//
//  FinalFrameStrikeState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

class FinalFrameBaseState: FinalFrameState {
    
    var ballsForScoring: [UInt]? {
        return frame?.ballKnockedDownRecord
    }

    fileprivate weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        guard !canBeScored else { return }
        frame?.addBallKnockedDownRecord(count: count)
    }
}


final class FinalFrameStrikeState: FinalFrameBaseState {}
final class FinalFrameSpareState: FinalFrameBaseState {}



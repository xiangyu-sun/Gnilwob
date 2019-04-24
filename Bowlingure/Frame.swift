//
//  Frame.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

class Frame {
    
    static let maxiumPinsCount: UInt = 10
    
    private(set) var ballKnockedDownRecord = [UInt]()
    
    lazy var state: FrameState = {
        return EmptyState(self)
    }()
    
    weak var scoringFrame: Frame?
    
    let lastFrame: Bool

    var calcualtedScore: UInt {
        return state.calcualtedScore
    }
    
    var isCompleted: Bool {
        return state.isFrameCompleted
    }
    
    var isCompletelyScored: Bool {
       return state.canBeScored
    }
    
    var pinsLeft: UInt {
        return Frame.maxiumPinsCount - (ballKnockedDownRecord.first ?? 0)
    }
    
    init(lastFrame: Bool = false) {
        self.lastFrame = lastFrame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        state.addPinsKnockedDown(count)
    }
    
    func addBallKnockedDownRecord(count: UInt) {
        ballKnockedDownRecord.append(count)
    }
    
    func getFirstBallRolledState() -> FirstBallRolledState {
        return FirstBallRolledState(self)
    }
    
    func getStrikeState() -> StrikeState {
        return StrikeState(self)
    }
    
    func getFinalFrameStrikeState() -> FinalFrameStrikeState {
        return FinalFrameStrikeState(self)
    }
    
    func getSpareState() -> SpareState {
        return SpareState(self)
    }
    
    func getFinalFrameSpareState() -> FinalFrameSpareState {
        return FinalFrameSpareState(self)
    }
    
    func getMissedState() -> MissedState {
        return MissedState(self)
    }
}

//
//  Frame.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

class Frame {
    static let maximumBallCount: UInt = 2
    static let maxiumPinsCount: UInt = 10
    
    fileprivate var ballKnockedDownRecord = [UInt]()
    fileprivate(set) var state: FrameState?
    weak var scoringFrame: Frame?
    
    var isCompleted: Bool {
        guard let state = self.state, !(state is FirstBallRolledState) else { return false }
        return true
    }
    
    var pinsLeft: UInt {
        return Frame.maxiumPinsCount - (ballKnockedDownRecord.first ?? 0)
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        state?.addPinsKnockedDown(count)
    }
    
    fileprivate func getFirstBallRolledState() -> FirstBallRolledState {
        return FirstBallRolledState(self)
    }
    
    fileprivate func getStrikeState() -> StrikeState {
        return StrikeState(self)
    }
    
    fileprivate func getSpareState() -> SpareState {
        return SpareState(self)
    }
    
    fileprivate func getMissedState() -> MissedState {
        return MissedState(self)
    }
}

protocol FrameState {
    init(_ frame: Frame)
    var calcualtedScore: UInt { get }
    func addPinsKnockedDown(_ count: UInt)
}

class StrikeState: FrameState {
    var calcualtedScore: UInt {
        return 1
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        guard frame?.ballKnockedDownRecord.count == 0 else { return }
        frame?.ballKnockedDownRecord.append(count)
    }
}

class FirstBallRolledState: FrameState {
    var calcualtedScore: UInt {
        return 1
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        if frame?.ballKnockedDownRecord.count == 0 {
            frame?.ballKnockedDownRecord.append(count)
        } else if count == frame?.pinsLeft {
            frame?.state = frame?.getSpareState()
        } else {
            frame?.state = frame?.getMissedState()
        }
    }
}

class SpareState: FrameState {
    var calcualtedScore: UInt {
        return 1
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        // end of frame
    }
}


class MissedState: FrameState {
    var calcualtedScore: UInt {
        return 1
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        // end of frame
    }
}

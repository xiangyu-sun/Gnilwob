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
    
    var calcualtedScore: UInt {
        return state?.calcualtedScore ?? 0
    }
    
    var isCompleted: Bool {
        return state?.isFrameCompleted ?? false
    }
    
    var isCompletelyScored: Bool {
       return state?.canBeScored ?? false
    }
    
    var pinsLeft: UInt {
        return Frame.maxiumPinsCount - (ballKnockedDownRecord.first ?? 0)
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        if state == nil {
            state = count == Frame.maxiumPinsCount ? getStrikeState() : getFirstBallRolledState()
        }
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
    var isFrameCompleted: Bool { get }
    var canBeScored: Bool { get }
    var calcualtedScore: UInt { get }
    func addPinsKnockedDown(_ count: UInt)
}

class StrikeState: FrameState {
    var canBeScored: Bool {
        return (frame?.scoringFrame?.state != nil && !(frame?.scoringFrame?.state is FirstBallRolledState))
    }
    
    var isFrameCompleted: Bool {
        return true
    }
    
    var calcualtedScore: UInt {
        var frames = frame?.ballKnockedDownRecord
        frames?.append(contentsOf: frame?.scoringFrame?.ballKnockedDownRecord ?? [])
        return frames?.sum() ?? 0
    }
    
    fileprivate weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        guard frame?.ballKnockedDownRecord.count == 0 else { return }
        frame?.ballKnockedDownRecord.append(count)
    }
}

class FirstBallRolledState: FrameState {
    
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
            frame?.ballKnockedDownRecord.append(count)
        } else if count == frame?.pinsLeft {
            frame?.state = frame?.getSpareState()
            frame?.state?.addPinsKnockedDown(count)
        } else {
            frame?.state = frame?.getMissedState()
            frame?.state?.addPinsKnockedDown(count)
        }
    }
}

class SpareState: FrameState {
    
    var canBeScored: Bool {
        return frame?.scoringFrame?.state != nil
    }
    
    var isFrameCompleted: Bool {
        return true
    }
    
    var calcualtedScore: UInt {
        var frames = frame?.ballKnockedDownRecord
        frames?.append(frame?.scoringFrame?.ballKnockedDownRecord.first ?? 0)
        return frames?.sum() ?? 0
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        frame?.ballKnockedDownRecord.append(count)
    }
}


class MissedState: FrameState {
    
    var canBeScored: Bool {
        return true
    }
    
    var isFrameCompleted: Bool {
        return true
    }
    
    var calcualtedScore: UInt {
        return frame?.ballKnockedDownRecord.sum() ?? 0
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        frame?.ballKnockedDownRecord.append(count)
    }
}

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
    
    fileprivate var ballKnockedDownRecord = [UInt]()
    fileprivate(set) lazy var state: FrameState = {
        return EmptyState(self)
    }()
    weak var scoringFrame: Frame?

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
    fileprivate let lastFrame: Bool
    
    init(lastFrame: Bool = false) {
        self.lastFrame = lastFrame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        state.addPinsKnockedDown(count)
    }
    
    fileprivate func getFirstBallRolledState() -> FirstBallRolledState {
        return FirstBallRolledState(self)
    }
    
    fileprivate func getStrikeState() -> StrikeState {
        return StrikeState(self)
    }
    
    fileprivate func getLastFrameStrikeState() -> LastFrameStrikeState {
        return LastFrameStrikeState(self)
    }
    
    fileprivate func getSpareState() -> SpareState {
        return SpareState(self)
    }
    
    fileprivate func getLastFrameSpareState() -> LastFrameSpareState {
        return LastFrameSpareState(self)
    }
    
    fileprivate func getMissedState() -> MissedState {
        return MissedState(self)
    }
}

protocol FrameState {
    init(_ frame: Frame)
    
    var maximumBallCount: UInt { get }
    var isFrameCompleted: Bool { get }
    var canBeScored: Bool { get }
    var calcualtedScore: UInt { get }
    var ballsForScoring: [UInt]? { get }
    
    func addPinsKnockedDown(_ count: UInt)
}


class EmptyState: FrameState {
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
        return 0
    }
    
    fileprivate weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        if let strikeState: FrameState = frame?.lastFrame == true ? frame?.getLastFrameStrikeState() : frame?.getStrikeState(), let firstState: FrameState = frame?.getFirstBallRolledState(){
            frame?.state = count == Frame.maxiumPinsCount ? strikeState : firstState
            frame?.state.addPinsKnockedDown(count)
        }
    }
}

class StrikeState: FrameState {
    var maximumBallCount: UInt {
        return 2
    }
    
    var ballsForScoring: [UInt]? {
        var frames = frame?.ballKnockedDownRecord
        frames?.append(contentsOf: frame?.scoringFrame?.ballKnockedDownRecord ?? [])
        
        let ballsCount = frames?.count ?? 0
        if ballsCount < 3, let firstBallOfNextFrame = frame?.scoringFrame?.scoringFrame?.ballKnockedDownRecord.first {
            frames?.append(firstBallOfNextFrame)
        } else if ballsCount > 3 {
            frames?.removeLast()
        }
        return frames
    }
    
    var canBeScored: Bool {
        return ballsForScoring?.count == 3
    }
    
    var isFrameCompleted: Bool {
        return true
    }
    
    var calcualtedScore: UInt {
        return ballsForScoring?.sum() ?? 0
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

class LastFrameStrikeState: FrameState {
    
    var maximumBallCount: UInt {
        return 3
    }
    
    var ballsForScoring: [UInt]? {
        return frame?.ballKnockedDownRecord
    }
    
    var canBeScored: Bool {
        return frame?.ballKnockedDownRecord.count == 3
    }
    
    var isFrameCompleted: Bool {
        return canBeScored
    }
    
    var calcualtedScore: UInt {
        return ballsForScoring?.sum() ?? 0
    }
    
    fileprivate weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        frame?.ballKnockedDownRecord.append(count)
    }
}

class FirstBallRolledState: FrameState {
    
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
            frame?.ballKnockedDownRecord.append(count)
        } else if count == frame?.pinsLeft, let state: FrameState = frame?.lastFrame == true ? frame?.getLastFrameSpareState() : frame?.getSpareState(){
            frame?.state = state
            frame?.state.addPinsKnockedDown(count)
        } else if let state: FrameState = frame?.getMissedState(){
            frame?.state = state
            frame?.state.addPinsKnockedDown(count)
        }
    }
}

class SpareState: FrameState {
    var maximumBallCount: UInt {
        return 2
    }
    var ballsForScoring: [UInt]? {
        var frames = frame?.ballKnockedDownRecord
        if let firstBallOfNextFrame = frame?.scoringFrame?.ballKnockedDownRecord.first {
            frames?.append(firstBallOfNextFrame)
        }
        return frames
    }
    
    var canBeScored: Bool {
        return ballsForScoring?.count == 3
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
        frame?.ballKnockedDownRecord.append(count)
    }
}

class LastFrameSpareState: FrameState {
    var maximumBallCount: UInt {
        return 3
    }
    var ballsForScoring: [UInt]? {
        return frame?.ballKnockedDownRecord
    }
    
    var canBeScored: Bool {
        return ballsForScoring?.count == 3
    }
    
    var isFrameCompleted: Bool {
        return canBeScored
    }
    
    var calcualtedScore: UInt {
        return ballsForScoring?.sum() ?? 0
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
        frame?.ballKnockedDownRecord.append(count)
    }
}

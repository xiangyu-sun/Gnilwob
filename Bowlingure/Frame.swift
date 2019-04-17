//
//  Frame.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

class Frame {
    static let maximumBallCount = 2
    static let maxiumPinsCount = 10
    
    private(set) var ballKnockedDownRecord = [Int]()
    private(set) var state: FrameState?
    
    func setState(_ state: FrameState) {
        self.state = state
    }
    
    func getStrikeState() -> StrikeState {
        return StrikeState(self)
    }
    
    func getSpareState() -> SpareState {
        return SpareState(self)
    }
    
    func getMissedState() -> MissedState {
        return MissedState(self)
    }
}

protocol FrameState {
    init(_ frame: Frame)
}

class StrikeState: FrameState {
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    
}

class SpareState: FrameState {
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
}


class MissedState: FrameState {
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
}

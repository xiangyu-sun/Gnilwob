//
//  FrameState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public protocol FrameState {
    init(_ frame: Frame)
    
    var maximumBallCount: UInt { get }
    var isFrameCompleted: Bool { get }
    var canBeScored: Bool { get }
    var calcualtedScore: UInt { get }
    var ballsRequiredForScoring: UInt { get }
    var ballsForScoring: [UInt]? { get }
    
    func addPinsKnockedDown(_ count: UInt)
}

extension FrameState{
    public var maximumBallCount: UInt {
        return 2
    }
    
    public var ballsRequiredForScoring: UInt {
        return maximumBallCount
    }
    
    public var calcualtedScore: UInt {
        return ballsForScoring?.sum() ?? 0
    }
    
    public var canBeScored: Bool {
        return ballsForScoring?.count == ballsRequiredForScoring
    }
}

public protocol CompleteFrameState: FrameState {

}

extension CompleteFrameState {
    public var isFrameCompleted: Bool {
        return true
    }
    
}

public protocol FinalFrameState: FrameState {

}

extension FinalFrameState {
    public var maximumBallCount: UInt {
        return 3
    }
    
    public var isFrameCompleted: Bool {
        return canBeScored
    }
    
}

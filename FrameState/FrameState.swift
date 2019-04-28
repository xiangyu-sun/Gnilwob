//
//  FrameState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

protocol FrameState {
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
    var maximumBallCount: UInt {
        return 2
    }
    
    var ballsRequiredForScoring: UInt {
        return maximumBallCount
    }
    
    var calcualtedScore: UInt {
        return ballsForScoring?.sum() ?? 0
    }
    
    var canBeScored: Bool {
        return ballsForScoring?.count == ballsRequiredForScoring
    }
}

protocol CompleteFrameState: FrameState {

}

extension CompleteFrameState {
    var isFrameCompleted: Bool {
        return true
    }
    
}

protocol FinalFrameState: FrameState {

}

extension FinalFrameState {
    var maximumBallCount: UInt {
        return 3
    }
    
    var isFrameCompleted: Bool {
        return canBeScored
    }
    
}

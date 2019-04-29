//
//  EmptyState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public final class EmptyState: FrameState {
    public func isFrameCompleted(_ frame: Frame) -> Bool {
        return false
    }
    
    public func ballsForScoring(_ frame: Frame) -> [UInt]? {
        return nil
    }
    
    public func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        frame.state = count == Frame.maxiumPinsCount ? frame.getStrikeState() : frame.getFirstBallRolledState()
        frame.state.addPinsKnockedDown(count, frame: frame)
    }
}

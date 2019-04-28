//
//  EmptyState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public class EmptyState: FrameState {

    public var ballsForScoring: [UInt]? {
        return nil
    }
    
    
    public var isFrameCompleted: Bool {
        return false
    }
    
    private weak var frame: Frame?
    
    public required init(_ frame: Frame) {
        self.frame = frame
    }
    
    public func addPinsKnockedDown(_ count: UInt) {
        if let frame = frame{
            frame.state = count == Frame.maxiumPinsCount ? frame.getStrikeState() : frame.getFirstBallRolledState()
            frame.state.addPinsKnockedDown(count)
        }
    }
}

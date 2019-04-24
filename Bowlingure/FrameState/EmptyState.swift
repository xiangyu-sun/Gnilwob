//
//  EmptyState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

class EmptyState: FrameState {

    var ballsForScoring: [UInt]? {
        return nil
    }
    
    var canBeScored: Bool {
        return false
    }
    
    var isFrameCompleted: Bool {
        return false
    }
    
    private weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        if let frame = frame{
            frame.state = count == Frame.maxiumPinsCount ? frame.getStrikeState() : frame.getFirstBallRolledState()
            frame.state.addPinsKnockedDown(count)
        }
    }
}

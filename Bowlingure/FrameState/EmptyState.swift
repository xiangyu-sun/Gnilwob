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
    
    fileprivate weak var frame: Frame?
    
    required init(_ frame: Frame) {
        self.frame = frame
    }
    
    func addPinsKnockedDown(_ count: UInt) {
        if let strikeState: FrameState = frame?.lastFrame == true ? frame?.getFinalFrameStrikeState() : frame?.getStrikeState(), let firstState: FrameState = frame?.getFirstBallRolledState(){
            frame?.state = count == Frame.maxiumPinsCount ? strikeState : firstState
            frame?.state.addPinsKnockedDown(count)
        }
    }
}

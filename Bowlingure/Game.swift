//
//  Game.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

struct Game {
    static let maximumFrameCount: UInt = 10
    
    private(set) var frames = [Frame]()
    
    var completedFrames: [Frame] {
        return frames.filter{ $0.isCompleted }
    }
    
    var nextFrameNumber: UInt {
        return min(Game.maximumFrameCount, UInt(frames.count) + 1)
    }
    
    var isGameover: Bool {
        return frames.count >= Game.maximumFrameCount
    }
    
    mutating func rolledWith(pinsKnockedDown: UInt) {
        guard !isGameover else { return }

        if frames.isEmpty || frames.last?.isCompleted == true {
            let newFrame = Frame()
            
            if frames.last?.state is StrikeState || frames.last?.state is SpareState{
                frames.last?.scoringFrame = newFrame
            }
            
            frames.append(newFrame)
        }
        
        frames.last?.addPinsKnockedDown(pinsKnockedDown)
    }

}

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
    
    private var currentFrame: Frame {
        if let currentFrame = frames.last {
            return currentFrame
        }
        let frame = Frame()
        return frame
    }

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
        
        if currentFrame.isCompleted {
            frames.append(Frame())
        }
        
        currentFrame.addPinsKnockedDown(pinsKnockedDown)
    }

}

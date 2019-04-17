//
//  Game.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

struct Game {
    static let maximumFrameCount = 10
    
    private(set) var frames = [Frame]()

    var completedFrames: [Frame] {
        return frames.filter{ $0.isCompleted }
    }
    
    var nextFrameNumber: Int {
        return min(Game.maximumFrameCount, frames.count + 1)
    }
    
    var isGameover: Bool {
        return frames.count == Game.maximumFrameCount
    }

}

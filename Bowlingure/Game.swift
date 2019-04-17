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
    
    var nextFrameNumber: Int {
        return min(Game.maximumFrameCount, frames.count + 1)
    }
    
    
}

//
//  Scorer.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

struct Scorer {
    let game: Game
    
    var frameNumber: String {
        return String(describing: game.nextFrameNumber)
    }
    
    var gameIsOver: Bool {
        return false
    }
    
    var scoreSoFar: String {
        return ""
    }
    
    init() {
        self.game = Game()
    }
    
    
    func rolledWith(pinsKnockedDown: Int) -> [Int] {
        return [0]
    }
}

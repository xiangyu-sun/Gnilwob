//
//  Scorer.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/17/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

struct Scorer {
    private(set) var game: Game
    
    var frameNumber: String {
        return String(describing: game.nextBallFrameNumber)
    }
    
    var gameIsOver: Bool {
        return game.isGameover
    }
    
    var scoreSoFar: String {
        return String(describing: calculateScore(frames: game.frames).reduce(0, +))
    }
    
    init() {
        self.game = Game()
    }
    
    @discardableResult
    mutating func rolledWith(pinsKnockedDown: UInt) -> [UInt] {
        if gameIsOver {
            game = Game()
        }
        
        game.rolledWith(pinsKnockedDown: pinsKnockedDown)
        
        return calculateScore(frames: game.completelyScoredFames)
    }
    
    @discardableResult
    mutating func rolledWith(pinsKnockedDownSequence: [UInt]) -> [UInt] {
        return pinsKnockedDownSequence.compactMap { self.rolledWith(pinsKnockedDown: $0) }.last ?? []
    }
    
    private func calculateScore(frames: [Frame]) -> [UInt] {
        return frames.map { $0.calcualtedScore }
    }
}

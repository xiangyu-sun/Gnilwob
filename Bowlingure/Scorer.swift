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
        return String(describing: game.frames.mapToScores.sum())
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
        
        return cuculativeScores(frames: game.completelyScoredFames)
    }
    
    @discardableResult
    mutating func rolledWith(pinsKnockedDownSequence: [UInt]) -> [UInt] {
        return pinsKnockedDownSequence.compactMap { self.rolledWith(pinsKnockedDown: $0) }.last ?? []
    }
    
    private func cuculativeScores(frames: [Frame]) -> [UInt] {
        return frames.enumerated().map { frames[...$0.0].mapToScores.sum()}
    }
}

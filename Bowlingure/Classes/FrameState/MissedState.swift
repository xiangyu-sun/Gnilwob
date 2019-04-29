//
//  MissedState.swift
//  Bowlingure
//
//  Created by 孙翔宇 on 4/24/19.
//  Copyright © 2019 孙翔宇. All rights reserved.
//

import Foundation

public final class MissedState: CompleteFrameState {
    public func addPinsKnockedDown(_ count: UInt, frame: Frame) {
        frame.addBallKnockedDownRecord(count: count)
    }
}

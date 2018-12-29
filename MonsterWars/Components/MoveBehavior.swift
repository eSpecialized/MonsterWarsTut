//
//  MoveBehavior.swift
//  MonsterWars
//
//  Created by William Thompson on 12/28/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveBehavior: GKBehavior {
    init(targetSpeed: Float, seek: GKAgent, avoid: [GKAgent]) {
        super.init()

        if targetSpeed > 0 {
            setWeight(0.1, for: GKGoal(toReachTargetSpeed: targetSpeed))
            setWeight(0.5, for: GKGoal(toSeekAgent: seek))
            setWeight(1.0, for: GKGoal(toAvoid: avoid, maxPredictionTime: 1.0))
        }
    }
}

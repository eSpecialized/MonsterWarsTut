//
//  Quirk.swift
//  MonsterWars
//
//  Created by William Thompson on 12/28/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class Quirk: GKEntity {
    init(team: Team) {
        super.init()
        let texture = SKTexture(imageNamed: "quirk\(team.rawValue)")
        let spriteComponent = SpriteComponent(texture: texture)
        addComponent(spriteComponent)
        addComponent(TeamComponent(team: team))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}

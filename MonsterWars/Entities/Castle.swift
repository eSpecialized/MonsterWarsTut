//
//  Castle.swift
//  MonsterWars
//
//  Created by William Thompson on 12/28/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class Castle: GKEntity {
    init(imageName: String, team: Team, entityManager: EntityManager) {
        super.init()

        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: imageName))
        addComponent(spriteComponent)

        addComponent(TeamComponent(team: team))

        addComponent(CastleComponent())

        addComponent(MoveComponent(maxSpeed: 0, maxAcceleration: 0, radius: Float(spriteComponent.node.size.width / 2), entityManager: entityManager))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}

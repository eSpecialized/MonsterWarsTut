//
//  SpriteComponent.swift
//  MonsterWars
//
//  Created by William Thompson on 12/28/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    let node: SKSpriteNode

    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
}

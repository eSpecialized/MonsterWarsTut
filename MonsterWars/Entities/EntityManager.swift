//
//  EntityManager.swift
//  MonsterWars
//
//  Created by William Thompson on 12/28/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    let scene: SKScene

    lazy var componentSystems: [GKComponentSystem] = {
        let castleSystem = GKComponentSystem(componentClass: CastleComponent.self)
        return [castleSystem]
    }()

    init(scene: SKScene) {
        self.scene = scene
    }

    func add(_ entity: GKEntity) {
        entities.insert(entity)
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }

    func remove(_ entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        entities.remove(entity)
        toRemove.insert(entity)
    }

    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }

        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        toRemove.removeAll()
    }

    func castle(for team: Team) -> GKEntity? {
        for entity in entities {
            if let teamComponent = entity.component(ofType: TeamComponent.self),
                let _ = entity.component(ofType: CastleComponent.self) {
                if teamComponent.team == team {
                    return entity
                }
            }
        }
        return nil
    }

    func spawnQuirk(team: Team) {
        guard let teamEntity = castle(for: team),
            let teamCastleComponent = teamEntity.component(ofType: CastleComponent.self),
            let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
                return
        }

        if teamCastleComponent.coins < costQuirk {
            return
        }

        teamCastleComponent.coins -= costQuirk
        scene.run(SoundManager.sharedInstance.soundSpawn)

        let monster = Quirk(team: team)
        if let spriteComponent = monster.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
            spriteComponent.node.zPosition = 2
        }
        add(monster)
    }
}

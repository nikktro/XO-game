//
//  LogCommand.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 9/10/20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class LogCommand {
    
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch self.action {
        case .playerInput(let player, let position):
            return "\(player) placed mark at position \(position)"
        case .gameFinisher(let winner):
            if let winner = winner {
                return "\(winner) win the game"
            } else {
                return "draw"
            }
        }
    }
}

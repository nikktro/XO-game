//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Nikolay Trofimov on 02.10.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

public class ComputerInputState: GameState {
    
    public private(set) var isCompleted = false
    public let markViewPrototype: MarkView // Prototype
    
    public let player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(player: Player, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView    ) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.markViewPrototype = markViewPrototype //Prototype
    }
    
    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        
        //< random position
        var randomColumn = 0
        var randomRow = 0
        repeat {
            randomColumn = Int.random(in: 0..<GameboardSize.rows)
            randomRow = Int.random(in: 0..<GameboardSize.columns)
            
            // check remaing turns, if no cell available - exit
            var countEmptyCell = 0
            for row in (0..<GameboardSize.rows) {
                for column in (0..<GameboardSize.columns) {
                    if gameboard?.positions[column][row] == nil {
                        countEmptyCell += 1
                    }
                }
            }
            if countEmptyCell == 0 { break }
        } while (gameboard?.positions[randomColumn][randomRow] != nil)
        
        let position = GameboardPosition(column: randomColumn, row: randomRow)
        //> random position
        
        log(.playerInput(player: self.player, position: position))
        
        guard let gameboardView = self.gameboardView
            , gameboardView.canPlaceMarkView(at: position)
            else { return }
        
        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
        

    }
}

//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

public class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private let gameboard = Gameboard()
    private lazy var referee = Referee(gameboard: self.gameboard)
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            } else {
                print("State is not completed")
            }
        }
    }
    
    private func goToFirstState() {
        let player = Player.first
        self.currentState = PlayerInputState(player: .first,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView,
                                             markViewPrototype: player.markViewPrototype)
    }

    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            log(.gameFinisher(winner: winner))
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        
        
        
        if let playerInputState = currentState as? PlayerInputState {
            let player = playerInputState.player.next
            self.currentState = PlayerInputState(player: playerInputState.player.next,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView,
                                                 markViewPrototype: player.markViewPrototype)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
    }
}


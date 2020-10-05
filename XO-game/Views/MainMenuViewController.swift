//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Nikolay Trofimov on 27.09.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    
    @IBOutlet weak var opponentSegment: UISegmentedControl!
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "startGame":
            guard let gameVC = segue.destination as? GameViewController else { return }
            gameVC.opponentSelector = opponentSegment.selectedSegmentIndex
        default:
            break
        }
    }

}

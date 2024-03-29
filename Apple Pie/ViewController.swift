//
//  ViewController.swift
//  Apple Pie
//
//  Created by Bailey Baskett on 11/18/19.
//  Copyright © 2019 Bailey Baskett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["otorhinolaryngological", "immunoelectrophoretically", "psychophysicotherapeutics", "thyroparathyroidectomized", "pneumoencephalographically", "radioimmunoelectrophoresis", "psychoneuroendocrinological", "hepaticocholangiogastrostomy", "spectrophotofluorometrically", "pseudopseudohypoparathyroidism", "buccaneer", "swift", "glorious", "incandecant", "bug", "program", "western", "supercalifragilisticexpialidocious", "awkward", "bagpipes", "banjo", "bungler", "croquet", "crypt", "dwarves", "fervid", "jazz", "ziggzagging", "cuff", "faux", "bomb", "tomb", "dump", "mock", "baby", "buff", "puff", "pneumonoultramicroscopicsilicovolcanoconiosis"]
    var allWords: [String] = []
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if allWords.count == 0{
            allWords = listOfWords
        }
        newRound()
        
    }
    
    func newRound() {
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI () {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    @IBAction func restartButton(_ sender: Any) {
        totalWins = 0
        totalLosses = 0
        listOfWords = allWords
        newRound()
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBAction func skipButton(_ sender: Any) {
        totalLosses += 1
        //newRound()
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
}


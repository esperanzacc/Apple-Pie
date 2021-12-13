//
//  ViewController.swift
//  Apple Pie1
//
//  Created by Esperanza on 12/13/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var lettersButton: [UIButton]!
    
   
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7

    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
        updateUI()
    }
    
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            updateUI()
            enableLettersButton(true)
            updateUI()
        }else {
            enableLettersButton(false)
        }
            
        }
    
    func enableLettersButton(_ enable: Bool) {
        for button in lettersButton {
            button.isEnabled = enable
        }
    }
        
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.titleLabel!.text!
        //I meet the problem about sender.title(for: .normal)! code from Swift textbook, then I google how to fix it and find the solution → sender.titleLabel!.text! indicated from https://developer.apple.com/forums/thread/692151 (devloper.apple.com, this solution helped by one user named willgucsb)
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameStore()
    }
    
    func updateGameStore() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }else {
            updateUI()
        }
    }
    
    
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
   


}


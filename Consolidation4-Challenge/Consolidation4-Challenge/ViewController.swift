//
//  ViewController.swift
//  Consolidation4-Challenge
//
//  Created by Henrik Forsberg on 2019-09-05.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

/*
 hangman game using UIKit.
 choosing a random word from a list of possibilities, but presenting it to the user as a series of underscores.
 So, if your word was “RHYTHM” the user would see “??????”.

 The user can then guess letters one at a time: if they guess a letter that it’s in the word, e.g. H, it gets revealed to make “?H??H?”; if they guess an incorrect letter, they inch closer to death. If they seven incorrect answers they lose, but if they manage to spell the full word before that they win.

 - load a list of words from disk and choose one,
 - prompt the user for text input
 - only accept single letters rather than whole words – use someString.count for that.
 - display the user’s current word and score using the title property of your view controller.
 - create a usedLetters array as well as a wrongAnswers integer.
 - When the player wins or loses, use UIAlertController to show an alert with a message

 */

class ViewController: UIViewController {

    var possibleWords = [String]()
    var wrongAnswers: Int = 0
    var usedLetters = [String]()
    var word = ""
    var resultWord = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        performSelector(inBackground: #selector(loadWords), with: nil)
    }

    @objc func loadWords() {
        if let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL) {
                possibleWords = words.components(separatedBy: "\n")
            }
        }
        print(possibleWords)
        DispatchQueue.main.async { [weak self] in
            self?.possibleWords.shuffle()

            if let word = self?.possibleWords.first {
                print(word)
                self?.word = word
                self?.setTitle()
                self?.promptForLetter()
            }
        }
    }

    func setTitle() {
        var titleWord = [String]()

        for letter in word {
            if usedLetters.contains(String(letter)) {
                titleWord.append(String(letter))
            } else {
                titleWord.append("?")
            }
        }

        resultWord = titleWord.joined()
        title = "\(resultWord) - \(String(wrongAnswers))"
    }

    func promptForLetter(action: UIAlertAction? = nil) {
        let ac = UIAlertController(title: "Enter letter", message: "Choose a letter. Choose wisely!", preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func submit(_ answer: String) {
        if isAnswerValid(answer: answer) {
            print("Your guess: \(answer)")
            usedLetters.append(answer)

            if word.contains(answer) {
                // update title
                setTitle()

            } else {
                wrongAnswers += 1
                setTitle()
            }

            if resultWord == word {
                showEndAlert(success: true)
            } else if wrongAnswers == 7 {
                showEndAlert(success: false)
            } else {
                promptForLetter()
            }
        }
    }

    func isAnswerValid(answer: String) -> Bool {
        if answer.count != 1 {
            showError(message: "You can only guess one letter at a time!")
            return false
        }
        if usedLetters.contains(answer) {
            showError(message: "You've already guessed this letter! Choose another.")
            return false
        }
        return true
    }

    func showEndAlert(success: Bool) {
        var title = ""
        var message = ""
        if success {
            title = "You won!"
            message = "You successfully avoided the gallows!"
        } else {
            title = "Game Over"
            message = "Your miserable life has come to an end."
        }
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "PLAY AGAIN", style: .default, handler: startGame))
        present(ac, animated: true)
    }

    func startGame(action: UIAlertAction) {

    }

    func showError(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: promptForLetter))
        present(ac, animated: true)
    }
}


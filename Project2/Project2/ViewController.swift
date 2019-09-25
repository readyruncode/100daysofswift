//
//  ViewController.swift
//  Project2
//
//  Created by Henrik Forsberg on 2019-06-11.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var asked = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        setTitle()

        asked += 1
    }

    func setTitle() {
        title = countries[correctAnswer].uppercased() + " Score: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        var buttonTitle: String
        var isFinal: Bool = false

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is now \(score)"
            buttonTitle = "Continue"
        } else {
            title = "Wrong"
            score -= 1
            message = "That's the flag of \(countries[sender.tag].capitalized)\nYour score is now \(score)"
            buttonTitle = "Continue"
        }

        setTitle()

        if asked == 10 {
            isFinal = true
        }

        showAlert(title: title, message: message, buttonTitle: buttonTitle, isFinal: isFinal)
    }

    func showAlert(title: String, message: String, buttonTitle: String, isFinal: Bool = false) {
        let handler = isFinal ? finish : askQuestion
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: handler))
        present(ac, animated: true)
    }

    func finish(action: UIAlertAction! = nil) {
        let defaults = UserDefaults.standard
        let highScore = defaults.integer(forKey: "highscore")
        if score > highScore {
            defaults.set(score, forKey: "highscore")
            showFinishAlert(title: "New High Score!", message: "You beat the previous high score of \(highScore)!\nThe new high score is now \(score)")
        } else {
            showFinishAlert(title: "10 questions asked!", message: "Your final score is \(score)")
        }
    }

    func showFinishAlert(title: String, message: String) {
        let ac = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        ac.addAction(
            UIAlertAction(title: "Play again", style: .default, handler: askQuestion))
        present(ac, animated: true)
        asked = 0
        score = 0
    }
}

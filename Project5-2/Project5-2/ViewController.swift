//
//  ViewController.swift
//  Project5
//
//  Created by Henrik Forsberg on 2019-07-14.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }

        navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

        let defaults = UserDefaults.standard
        let currentWord = defaults.string(forKey: "current")
        if currentWord != "" {
            title = currentWord
        }

        usedWords = defaults.object(forKey: "usedwords") as? [String] ?? [String]()
    }

    @objc func startGame() {
        title = allWords.randomElement()
        let defaults = UserDefaults.standard
        defaults.set(title!, forKey: "current")

        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
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
        let lowerAnswer = answer.lowercased()

        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    let defaults = UserDefaults.standard
                    defaults.set(usedWords, forKey: "usedwords")
                    tableView.insertRows(at: [indexPath], with: .automatic)

                    return
                } else {
                    showErrorMessage(errorTitle: "Word not recognized", errorMessage: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(errorTitle: "Word used already", errorMessage: "Be more original!")
            }
        } else {
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title!.lowercased())")
        }
    }

    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }

        if word == title!.lowercased() {
            return false
        }

        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {
        if word.count < 3 {
            return false
        }

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}


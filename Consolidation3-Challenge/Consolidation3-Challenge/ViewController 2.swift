//
//  ViewController.swift
//  Consolidation3-Challenge
//
//  Created by Henrik Forsberg on 2019-08-26.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shopping List"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(clearList))
    }

    @objc func clearList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }

    @objc func promptForItem() {
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            guard let entry = ac?.textFields?[0].text else { return }
            self?.addItem(item: entry)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func addItem(item: String) {
        let insertIndex = 0
        shoppingList.insert(item, at: insertIndex)
        let indexPath = IndexPath(row: insertIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - TableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]

        return cell
    }
}


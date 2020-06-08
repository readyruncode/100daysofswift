//
//  ViewController.swift
//  Consolidation2-Challenge
//
//  Created by Henrik Forsberg on 2019-07-01.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var flags: [String] = []
    var selectedRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasSuffix("png") {
                let startIndex = item.startIndex
                let endIndex = item.firstIndex(of: "@")!
                let range = startIndex ..< endIndex
                let flagName = String(item[range])
                if !flags.contains(flagName) {
                    flags.append(flagName)
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        cell.textLabel?.text = flags[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "detailSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let vc = segue.destination as? DetailViewController
            vc?.countryName = flags[selectedRow]
        }
    }
}

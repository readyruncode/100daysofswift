//
//  SiteListTableViewController.swift
//  Project4
//
//  Created by Henrik Forsberg on 2019-07-10.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

var sites = ["apple.com", "forsberg.dev"]

class SiteListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Project 4"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sites[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Browser") as? ViewController {
            vc.selectedSite = sites[indexPath.row]
//            print(vc.selectedSite)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

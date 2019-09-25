//
//  ViewController.swift
//  Project1
//
//  Created by Henrik Forsberg on 2019-06-10.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"

        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
            }
        }

        pictures.sort()

        print(pictures)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let imageName = pictures[indexPath.row]
        cell.textLabel?.text = imageName

        // As subtitle, display times shown
        let defaults = UserDefaults.standard
        cell.detailTextLabel?.text = String(defaults.integer(forKey: imageName))

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageCount = pictures.count
            vc.imageNumber = indexPath.row + 1

            // Increment times shown
            let defaults = UserDefaults.standard
            let timesShown = defaults.integer(forKey: vc.selectedImage!) // Returns saved count or zero
            defaults.set(timesShown + 1, forKey: vc.selectedImage!)
            tableView.reloadData()

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//
//  MyCollectionViewController.swift
//  Project1
//
//  Created by Henrik Forsberg on 2019-09-11.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class MyCollectionViewController: UICollectionViewController {

    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"

        navigationController?.navigationBar.prefersLargeTitles = true

        performSelector(inBackground: #selector(fetchImages), with: nil)

        print(pictures)
    }

    @objc func fetchImages() {
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

        collectionView.performSelector(onMainThread: #selector(collectionView.reloadData), with: nil, waitUntilDone: false)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue PictureCell.")
        }
        
        cell.textLabel.text = pictures[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageCount = pictures.count
            vc.imageNumber = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


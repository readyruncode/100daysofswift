//
//  DetailViewController.swift
//  Consolidation2-Challenge
//
//  Created by Henrik Forsberg on 2019-07-02.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var countryName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: countryName)
    }
    
    @IBAction func tappedShareButton(_ sender: Any) {
        print("share!")
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true, completion: nil)

    }
}

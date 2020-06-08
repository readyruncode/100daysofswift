//
//  DetailViewController.swift
//  Consolidation5-Challenge
//
//  Created by Henrik Forsberg on 2019-10-01.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = selectedImage {
            imageView.image = image
        }        
    }
}

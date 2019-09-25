//
//  DetailViewController.swift
//  Project1
//
//  Created by Henrik Forsberg on 2019-06-10.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIActivityItemSource {

    @IBOutlet var imageView: UIImageView!

    var selectedImage: String?
    var imageCount: Int = 0
    var imageNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture \(imageNumber) of \(imageCount)" //selectedImage
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: [], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        var returnValue = ""
        if activityType == .postToTwitter {
            returnValue = "Download #MyAwesomeApp via @readyruncode"
        }
        return returnValue
    }
}

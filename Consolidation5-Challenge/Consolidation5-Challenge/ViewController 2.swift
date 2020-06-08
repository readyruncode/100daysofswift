//
//  ViewController.swift
//  Consolidation5-Challenge
//
//  Created by Henrik Forsberg on 2019-09-25.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

/**
    let users take photos of things that interest them, add captions to them, then show those photos in a table view.
    Tapping the caption should show the picture in a new view controller
 */

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photos = [CaptionPhoto]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openImagePicker))

        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.originalImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        let photo = CaptionPhoto(image: imageName, caption: "")

        dismiss(animated: true)

        showAddCaptionAlert(photo)
    }

    func showAddCaptionAlert(_ photo: CaptionPhoto) {

        let ac = UIAlertController(title: "Add Caption", message: nil, preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newCaption = ac?.textFields?[0].text else { return }
            photo.caption = newCaption
            self?.photos.append(photo)
            self?.tableView.reloadData()
        })

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(ac, animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let testCell = tableView.dequeueReusableCell(withIdentifier: "CaptionPhotoCell", for: indexPath)
//        testCell.imageView

        let cell = tableView.dequeueReusableCell(withIdentifier: "CaptionPhotoCell", for: indexPath)
//            as? CaptionPhotoCell else {
//            fatalError("Unable to dequeue PersonCell.")
//        }
        let photo = photos[indexPath.row]

        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        cell.imageView!.image = UIImage(contentsOfFile: path.path)
        cell.textLabel!.text = photo.caption

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let photo = photos[indexPath.row]
            let path = getDocumentsDirectory().appendingPathComponent(photo.image)
            vc.selectedImage = UIImage(contentsOfFile: path.path)

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


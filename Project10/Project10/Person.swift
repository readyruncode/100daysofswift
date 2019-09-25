//
//  Person.swift
//  Project10
//
//  Created by Henrik Forsberg on 2019-09-10.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}

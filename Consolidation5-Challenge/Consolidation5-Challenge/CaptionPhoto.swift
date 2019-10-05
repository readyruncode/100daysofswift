//
//  CaptionPhoto.swift
//  Consolidation5-Challenge
//
//  Created by Henrik Forsberg on 2019-09-26.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import Foundation

class CaptionPhoto: Codable {
    var image: String
    var caption: String

    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}

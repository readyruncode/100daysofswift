//
//  Petition.swift
//  Project9
//
//  Created by Henrik Forsberg on 2019-08-27.
//  Copyright © 2019 ReadyRunCode. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

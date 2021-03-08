//
//  Photos.swift
//  Milestone10-12
//
//  Created by Ekaterina Tarasova on 08.03.2021.
//

import UIKit

class Photos: Codable {
    var image: String
    var name: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}

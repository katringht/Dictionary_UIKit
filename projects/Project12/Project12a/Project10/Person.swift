//
//  Person.swift
//  Project10
//
//  Created by Ekaterina Tarasova on 02.03.2021.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    
}

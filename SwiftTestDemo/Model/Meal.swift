//
//  Meal.swift
//  SwiftTestDemo
//
//  Created by user on 2019/3/25.
//  Copyright © 2019 adu. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //使用static关键字来声明这些常量，表示它们可用于Meal类的外部，你可以使用Meal.ArchiveURL.path来访问路径
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as! UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
        self.init(name: name, photo: photo, rating: rating)
    }
}

//
//  Item.swift
//  Todoey3
//
//  Created by Maxime Vacher-materno on 18-05-21.
//  Copyright © 2018 Maxime Vacher-materno. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}


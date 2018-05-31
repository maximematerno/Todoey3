//
//  Category.swift
//  Todoey3
//
//  Created by Maxime Vacher-materno on 18-05-21.
//  Copyright © 2018 Maxime Vacher-materno. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

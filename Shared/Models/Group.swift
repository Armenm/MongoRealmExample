//
//  Group.swift
//  MongoRealmExample (iOS)
//
//  Created by Armen Mkrtchian on 2021-01-19.
//

import Foundation
import Combine
import RealmSwift

/// Represents a collection of items.
final class Group: Object, ObjectKeyIdentifiable {
    /// The unique ID of the Group.
    @objc dynamic var _id = ObjectId.generate()

    /// The collection of Items in this group.
    let items = RealmSwift.List<Item>()

    /// Declares the _id member as the primary key to the realm.
    override class func primaryKey() -> String? {
        "_id"
    }
}

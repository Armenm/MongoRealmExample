//
//  FavoriteToggle.swift
//  MongoRealmExample (iOS)
//
//  Created by Armen Mkrtchian on 2021-01-19.
//

import SwiftUI

/// A control for toggling an item's isFavorite property. Demonstrates using a custom binding
/// to modify a Realm object in a transaction.
struct FavoriteToggle: View {
    var item: Item
    var body: some View {
        // ⚠️ We cannot use the item property directly, as sets will not
        // automatically run in a transaction. Here we provide a custom
        // binding to handle the update in a transaction.
        Toggle(isOn: Binding(get: {
            // Return the value as normal.
            item.isFavorite
        }, set: { (value) in
            // If the item is associated with a realm,
            // open a transaction on it in order to do
            // the write.
            guard let realm = item.realm else {
                item.isFavorite = value
                return
            }
            try! realm.write {
                item.isFavorite = value
            }
        })) {
            // 💡 It might have been nice to use a Button instead
            // of a Toggle, but that wouldn't demonstrate custom bindings.
            Image(systemName: item.isFavorite ? "heart.fill" : "heart")
        }
    }
}

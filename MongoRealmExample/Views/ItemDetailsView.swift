//
//  ItemDetailsView.swift
//  MongoRealmExample (iOS)
//
//  Created by Armen Mkrtchian on 2021-01-19.
//

import SwiftUI

/// Represents a screen where you can edit the item's name.
struct ItemDetailsView: View {
    var item: Item

    // ⚠️ Beware using a Realm object or its properties directly in a @Binding.
    // Writes to Realm objects MUST occur in a transaction (realm.write() block),
    // but a default Binding will not do that for you. Therefore, either use a
    // separate @State object to hold the data before writing (as we do here),
    // or create a custom Binding that handles writes in a transaction.
    @State var newItemName: String = ""

    init(_ item: Item) {
        // Ensure the item was thawed before passing in
        assert(!item.isFrozen)
        self.item = item
        self.newItemName = item.name
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter a new name:")
            // Write the new name to the newItemName state variable.
            // On commit, call our commit() function.
            TextField(item.name, text: $newItemName, onCommit: { self.commit() })
                .navigationBarTitle(item.name)
                .navigationBarItems(trailing: FavoriteToggle(item: item))
        }.padding()
    }

    /// Writes the given name to the realm in a transaction.
    private func commit() {
        guard let realm = item.realm else {
            item.name = newItemName
            return
        }
        try! realm.write {
            item.name = newItemName
        }
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView(Item())
    }
}

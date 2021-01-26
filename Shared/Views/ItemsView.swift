//
//  ItemsView.swift
//  MongoRealmExample (iOS)
//
//  Created by Armen Mkrtchian on 2021-01-19.
//

import SwiftUI
import RealmSwift

// MARK: Item Views
/// The screen containing a list of items in a group. Implements functionality for adding, rearranging,
/// and deleting items in the group.
struct ItemsView: View {
    /// The items in this group.
    @ObservedObject var items: RealmSwift.List<Item>

    /// The button to be displayed on the top left.
    var leadingBarButton: AnyView?

    var body: some View {
        NavigationView {
            VStack {
                // The list shows the items in the realm.
                List {
                    // ⚠️ ALWAYS freeze a Realm list while iterating in a SwiftUI
                    // View's ForEach(). Otherwise, unexpected behavior will occur,
                    // especially when deleting object from the list.
                    ForEach(items.freeze()) { frozenItem in
                        // "Thaw" the item before passing it in, as ItemRow
                        // may want to edit it, and cannot do so on a frozen object.
                        // This is a convenient place to thaw because we have access
                        // to the unfrozen realm via the items list.
                        ItemRow(item: items.realm!.resolve(ThreadSafeReference(to: frozenItem))!)
                    }.onDelete(perform: delete)
                        .onMove(perform: move)
                }.listStyle(GroupedListStyle())
                    .navigationBarTitle("Items", displayMode: .large)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(
                        leading: self.leadingBarButton,
                        // Edit button on the right to enable rearranging items
                        trailing: EditButton())

                // Action bar at bottom contains Add button.
                HStack {
                    Spacer()
                    Button(action: addItem) { Image(systemName: "plus") }
                }.padding()
            }
        }
    }

    /// Adds a new randomly-named item to the group.
    func addItem() {
        let newItem = Item()
        guard let realm = items.realm else {
            items.append(newItem)
            return
        }
        try! realm.write {
            items.append(newItem)
        }
    }

    /// Deletes the given item.
    func delete(at offsets: IndexSet) {
        guard let realm = items.realm else {
            items.remove(at: offsets.first!)
            return
        }
        try! realm.write {
            realm.delete(items[offsets.first!])
        }
    }

    /// Rearranges the given item in the group.
    /// This is persisted because the items are stored in a Realm List.
    func move(fromOffsets offsets: IndexSet, toOffset to: Int) {
        guard let realm = items.realm else {
            items.move(fromOffsets: offsets, toOffset: to)
            return
        }
        try! realm.write {
            items.move(fromOffsets: offsets, toOffset: to)
        }
    }
}

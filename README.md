# MongoRealmExample

[![CI Status](http://img.shields.io/travis/Armenm/MongoRealmExample.svg?style=flat)](https://travis-ci.org/Armenm/MongoRealmExample)

# Goal

### Quick Start with SwiftUI and Combine
A sample project to showcase Realm Database integration with SwiftUI and Combine.


# Screenshots
| Items List| Add/Remove | Details |
|--|--|--|
| ![Items List](https://i.imgur.com/CUDaFQr.png) | ![Add/Remove](https://i.imgur.com/6Dto1hL.png) | ![Item Details](https://i.imgur.com/SjPKyqq.png) |


# Roadmap

- [ ] Realtime sync with BE
- [ ] Login screen
- [ ] Different data types
- [ ] Guideline on setting up the MongoDB


# Installation

### Manual
1. Clone the repo
2. Run the app


# Usage

### Folder sturcture
    .
    ├── Application                 # ContentView: SwiftUI.App, Configuration
    ├── Models                      # Data Models
    ├── Views                       # Views
    ├── ReusableComponents          # Design system reusable components (in progress)
    ├── Resources                   # Assets, TestData, SwiftUI Preview Content, Info.plist
    └── README.md
    
<table>
 <thead>
<tr>
<th>Example code</th>
<th>Screenshot</th>
</tr>
</thead>
<tr>
<td>
<h3>Items List (ItemsListView.swift)</h3>
  <pre lang="swift">
  List {
      // ⚠️ ALWAYS freeze a Realm list while 
      // iterating in a SwiftUI View's ForEach(). 
      // Otherwise, unexpected behavior will occur,
      // especially when deleting object from the list.
      ForEach(items.freeze()) { frozenItem in
          // "Thaw" the item before passing it in, as ItemRow
          // may want to edit it, and 
          // cannot do so on a frozen object.
          // This is a convenient place 
          // to thaw because we have access
          // to the unfrozen realm via the items list.
          ItemRow(item: items.realm!
                .resolve(ThreadSafeReference(to: frozenItem))!)
      }
      .onDelete(perform: delete) // swipe to delete action
      .onMove(perform: move) // move items in editing mode
  }
  </pre>
</td>
<td>
 <img src="https://i.imgur.com/CUDaFQr.png" alt="Items List">
</td>
</tr>
<tr></tr>
<tr>
<td>
 <h3>Delete an item</h3>
  <pre lang="swift">
  // Deletes the given item.
  func delete(at offsets: IndexSet) {
     guard let realm = items.realm else {
          items.remove(at: offsets.first!)
          return
      }
      try! realm.write {
          realm.delete(items[offsets.first!])
      }
  }
  </pre>
</td>
<td>
 <img src="https://i.imgur.com/SZ6DkDJ.gif" alt="Delete an item">
</td>
</tr>
<tr></tr>
<tr>
<td>
 <h3>Add/update item name (ItemDetailsView.swift)</h3>
  <pre lang="swift">
  // Ensure the item was thawed before passing in
  init(_ item: Item) {
    assert(!item.isFrozen)
  }
  </pre>
  <pre lang="swift">
  // Whenever a user performs an action 
  // like pressing the return key, 
  // TextField calls onCommit closure
  TextField(item.name, text: $newItemName, onCommit: { 
    self.commit() 
  })
  </pre>
  <pre lang="swift">
  // Writes the given name to the realm in a transaction.
  private func commit() {
     guard let realm = item.realm else {
          item.name = newItemName
          return
      }
      try! realm.write {
          item.name = newItemName
      }
  }
  </pre>
</td>
<td>
 <img src="https://i.imgur.com/mtf0hWm.gif" alt="Add/update item name">
</td>
</tr>
<tr></tr>
<tr>
<td>
 <h3>Toggle favorite (ItemDetailsView.swift)</h3>
  <pre lang="swift">
  // ⚠️ We cannot use the item property 
  // directly, as sets will not
  // automatically run in a transaction. 
  // Here we provide a custom
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
  </pre>
</td>
<td>
 <img src="https://i.imgur.com/k57YLZ0.gif" alt="Toggle favorite">
</td>
</tr>
<tr></tr>
</table>

# Contacts

Mogoni.dev, [armen@mogoni.dev](mailto:armen@mogoni.dev)
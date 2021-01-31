//
//  Configuration.swift
//
//  Created by Armen Mkrtchian on 2021-01-19.
//

import Foundation
import RealmSwift

// MARK: MongoDB Realm (Optional)

// Set this to true if you have set up a MongoDB Realm app
// with Realm Sync and anonymous authentication.
let USE_REALM_SYNC = false

/// The Realm app. Change YOUR_REALM_APP_ID_HERE to your Realm app ID.
// If you don't have a Realm app and don't wish to use Sync for now,
// change this to:
//   let app: RealmSwift.App? = nil
let app = USE_REALM_SYNC ? App(id: "YOUR_REALM_APP_ID_HERE") : nil

//
//  ContentView.swift
//
//  Created by Armen Mkrtchian on 2021-01-19.
//

import SwiftUI

// MARK: Main View
/// The main screen that determines whether to present the LoginView or the ItemsListView for the one group in the realm.
@main
struct ContentView: SwiftUI.App {
    /// The state of this application.
    @ObservedObject var state = AppState()

    var view: some View {
        ZStack {
            // If a realm is open for a logged in user, show the ItemsListView
            // else show the LoginView
            if let items = state.items {
                // If using Realm Sync and authentication, provide a logout button
                // in the top left of the ItemsListView.
                let leadingBarButton = app != nil ? AnyView(LogoutButton().environmentObject(state)) : nil
                ItemsListView(items: items,
                              leadingBarButton: leadingBarButton)
                    .disabled(state.shouldIndicateActivity)
            } else {
                LoginView()
            }
            // If the app is doing work in the background,
            // overlay an ActivityIndicator
            if state.shouldIndicateActivity {
                ActivityIndicator()
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            // Pass the state object around as an EnvironmentObject
            view.environmentObject(state)
        }
    }
}

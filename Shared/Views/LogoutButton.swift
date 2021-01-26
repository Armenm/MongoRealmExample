//
//  LogoutButton.swift
//  MongoRealmExample (iOS)
//
//  Created by Armen Mkrtchian on 2021-01-19.
//

import SwiftUI

/// A button that handles logout requests.
struct LogoutButton: View {
    @EnvironmentObject var state: AppState
    var body: some View {
        Button("Log Out") {
            guard let app = app else {
                print("Not using Realm Sync - not logging out")
                return
            }
            state.shouldIndicateActivity = true
            app.currentUser?.logOut().receive(on: DispatchQueue.main).sink(receiveCompletion: { _ in }, receiveValue: {
                state.shouldIndicateActivity = false
                state.logoutPublisher.send($0)
            }).store(in: &state.cancellables)
        }.disabled(state.shouldIndicateActivity)
    }
}

//
//  LoginView.swift
//  MongoRealmExample (iOS)
//
//  Created by Armen Mkrtchian on 2021-01-19.
//

import SwiftUI

// MARK: Authentication Views
/// Represents the login screen. We will just have a button to log in anonymously.
struct LoginView: View {
    @EnvironmentObject var state: AppState
    // Display an error if it occurs
    @State var error: Error?

    var body: some View {
        VStack {
            if let error = error {
                Text("Error: \(error.localizedDescription)")
            }
            Button("Log in anonymously") {
                guard let app = app else {
                    print("Not using Realm Sync - not logging in")
                    return
                }
                state.shouldIndicateActivity = true
                app.login(credentials: .anonymous).receive(on: DispatchQueue.main).sink(receiveCompletion: {
                    state.shouldIndicateActivity = false
                    switch ($0) {
                    case .finished:
                        break
                    case .failure(let error):
                        self.error = error
                    }
                }, receiveValue: {
                    self.error = nil
                    state.loginPublisher.send($0)
                }).store(in: &state.cancellables)
            }.disabled(state.shouldIndicateActivity)
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

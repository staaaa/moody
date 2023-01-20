//
//  moodApp.swift
//  mood
//
//  Created by Stanisław Bożych on 05/12/2022.
//

import SwiftUI

@main
struct moodApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear(){
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
        }
    }
}

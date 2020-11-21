//
//  sample_timerApp.swift
//  sample-timer WatchKit Extension
//
//  Created by 川俣涼 on 2020/11/21.
//

import SwiftUI

@main
struct sample_timerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

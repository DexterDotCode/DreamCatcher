//
//  DreamcatcherApp.swift
//  Dreamcatcher
//

import SwiftData
import SwiftUI

@main
struct DreamcatcherApp: App {
    @State private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView(dataController: dataController)
        }
        .modelContainer(for: Dream.self)
    }
}

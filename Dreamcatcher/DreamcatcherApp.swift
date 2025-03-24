//
//  DreamcatcherApp.swift
//  Dreamcatcher
//

import AppIntents
import SwiftData
import SwiftUI


@main
struct DreamcatcherApp: App {
	@State private var dataController: DataController
	@State private var modelContainer: ModelContainer

    var body: some Scene {
        WindowGroup {
            ContentView(dataController: dataController)
        }
		.modelContainer(modelContainer)
    }
	
	init() {
		let modelContainer: ModelContainer
		
		do {
			modelContainer = try ModelContainer(for: Dream.self)
		} catch {
			print("Error loading modelContainer; switching to in-memory storage")
			let config = ModelConfiguration(isStoredInMemoryOnly: true)
			modelContainer = try! ModelContainer(for: Dream.self, configurations: config)
		}
		
		self._modelContainer = .init(initialValue: modelContainer)
		
		let dataController = DataController(modelContainer: modelContainer)
		self._dataController = .init(initialValue: dataController)
		
		AppDependencyManager.shared.add(dependency: dataController)
		
#if os(iOS)
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.backgroundColor = .bg
		navBarAppearance.backgroundEffect = .none
		navBarAppearance.shadowColor = .clear
		
		UINavigationBar.appearance().standardAppearance = navBarAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
		UINavigationBar.appearance().compactAppearance = navBarAppearance
#endif
	}
}

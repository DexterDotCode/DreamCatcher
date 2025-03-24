//
//  ShortcutsProvider.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents

// Only 1 AppShortcutsProvider struct should be there in a project.
struct ShortcutsProvider: AppShortcutsProvider {
	
	// This doesn't do shit by the way.
	// And we can't use SwiftUI colors or UIKit colors or even custom colors.
	static let shortcutTileColor: ShortcutTileColor = .pink
	
	// It accepts an array of shortcuts.
	static var appShortcuts: [AppShortcut] {
		AppShortcut(
			intent: CountRecentDreamsIntent(),
			phrases: ["Count my recent dreams in \(.applicationName)"],
			shortTitle: "Count Recent Dreams",
			systemImageName: "bubbles.and.sparkles"
		)
		
		AppShortcut(
			intent: AddToRecentDreamIntent(),
			phrases: ["Add content to my last dream in \(.applicationName)"],
			shortTitle: "Add content to recent dream",
			systemImageName: "moon.stars"
		)
		
		AppShortcut(
			intent: OpenDreamInAppIntent(),
			phrases: ["Open a dream in \(.applicationName) app"],
			shortTitle: "Open Dream in App",
			systemImageName: "sparkles"
		)
		
		AppShortcut(
			intent: OpenDreamDetailsIntent(),
			phrases: ["Open a dream in \(.applicationName)"],
			shortTitle: "Open Dream Details",
			systemImageName: "moon.zzz"
		)
	}
}

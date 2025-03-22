//
//  ShortcutsProvider.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents

struct ShortcutsProvider: AppShortcutsProvider {
	static let shortcutTileColor: ShortcutTileColor = .navy
	
	static var appShortcuts: [AppShortcut] {
		AppShortcut(
			intent: CountRecentDreamsIntent(),
			phrases: ["Count my recent dreams \(.applicationName)"],
			shortTitle: "Count Recent Dreams",
			systemImageName: "bubbles.and.sparkles"
		)
		
		AppShortcut(
			intent: DreamReminderIntent(),
			phrases: ["Remind me of a dream \(.applicationName)"],
			shortTitle: "Dream Reminder",
			systemImageName: "clock"
		)
		
		AppShortcut(
			intent: AddToRecentDreamIntent(),
			phrases: ["Add content to my last dream\(.applicationName)"],
			shortTitle: "Add content to recent dream",
			systemImageName: "moon.stars"
		)
	}
}

//
//  DreamReminderIntent.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents


struct DreamReminderIntent: AppIntent {
	@Dependency var dataController: DataController
	
	static let title: LocalizedStringResource = "Remind me of a dream"
	static let description: IntentDescription? = "Set a reminder of a dream"
	
	@Parameter var dream: DreamEntity
	
	func perform() async throws -> some IntentResult & ProvidesDialog {
		.result(dialog: "\(dream.details)")
	}
}

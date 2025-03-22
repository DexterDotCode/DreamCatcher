//
//  AddToPreviousDreamIntent.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents

struct AddToRecentDreamIntent: AppIntent {
	static let title: LocalizedStringResource = "Add to recent dream"
	static let description: IntentDescription? = "Add more content to your most recent dream"
	
	@Dependency var dataController: DataController
	
	@Parameter var content: String
	
	@MainActor
	func perform() async throws -> some IntentResult & ProvidesDialog {
		let dreams = try dataController.dreams(limit: 1)
		
		
		if let first = dreams.first {
			first.details.append("\(content)")
			try? first.modelContext?.save()
			return .result(dialog: "\(first.details)")
		} else {
			return .result(dialog: "You haven't log any dreams.")
		}
	}
}

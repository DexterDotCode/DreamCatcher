//
//  OpenDreamInAppIntent.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 23/03/25.
//

import AppIntents


struct OpenDreamInAppIntent: OpenIntent {
	static let title: LocalizedStringResource = "Open dream"
	
	@Dependency var dataController: DataController
	@Parameter var target: DreamEntity
	
	func perform() async throws -> some IntentResult {
		try await dataController.select(entity: target)
		return .result()
	}
}

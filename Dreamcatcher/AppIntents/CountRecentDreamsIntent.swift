//
//  CountRecentDreamsIntent.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents
import SwiftData


struct CountRecentDreamsIntent: AppIntent {
	static let title: LocalizedStringResource = "Recent Dream Count"
	static let description: IntentDescription? = "Gives the number of recent dreams"
	
	@Dependency var dataController: DataController
	
	@MainActor
	func perform() async throws -> some IntentResult & ProvidesDialog & ReturnsValue<Int> {
		let dateCutOff = Calendar.current.date(byAdding: .month, value: -1, to: .now) ?? .now
		
		let dreams = try dataController.dreamCount(matching: #Predicate {
			$0.date > dateCutOff
		})
		let message = AttributedString(localized: "You've had ^[\(dreams) dream](inflect: true)")
		
		return .result(value: dreams, dialog: "\(message)")
	}
}

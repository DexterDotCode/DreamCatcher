//
//  OpenDreamIntent.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents
import SwiftUI


struct OpenDreamDetails: AppIntent {
	static let title: LocalizedStringResource = "Open dream"
	@Parameter var target: DreamEntity
	
	func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
		return .result(dialog: "\(target.title)") {
			VStack(spacing: 7) {
				Image(systemName: "moon")
					.foregroundStyle(.yellow)
					.font(.largeTitle)
				
				HStack(spacing: 5) {
					Text(target.date.formatted(date: .abbreviated, time: .omitted))
						.font(.caption)
						.foregroundStyle(.secondary)
					
					Text("•")
						.font(.caption)
						.foregroundStyle(.secondary)
					
					Text(String(format: "Intensity: %.2f", target.intensity))
						.font(.caption)
						.foregroundStyle(.secondary)
				}
					
				
				VStack(alignment: .leading, spacing: 7) {
					
					Divider()
					
					Text(target.details)
						.font(.subheadline)
					
					Button(intent: OpenDreamInApp(target: $target), label: {
						Text("Open")
					})
					.buttonBorderShape(.roundedRectangle)
				}
			}
			.padding()
		}
	}
}

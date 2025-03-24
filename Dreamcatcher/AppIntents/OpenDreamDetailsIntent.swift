//
//  OpenDreamIntent.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents
import SwiftUI


struct OpenDreamDetailsIntent: AppIntent {
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
						.font(.footnote)
						.foregroundStyle(.secondary)
					
					Text("•")
						.font(.footnote)
						.foregroundStyle(.secondary)
					
					Text(String(format: "Intensity: %.2f", target.intensity))
						.font(.footnote)
						.foregroundStyle(.secondary)
				}
				VStack(alignment: .leading, spacing: 7) {
					Divider()
					
					Text(target.details)
						.font(.headline)
						.fontWeight(.regular)

					Button(intent: OpenDreamInAppIntent(target: $target), label: {
						HStack(spacing: 5) {
							Text("Open")
							Image(systemName: "arrow.up.right.circle.fill")
						}
					})
				}
			}
			.padding()
		}
	}
}

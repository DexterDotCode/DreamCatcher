//
//  DreamEditor.swift
//  Dreamcatcher
//

import CoreSpotlight
import SwiftUI

struct DreamEditor: View {
    @Bindable var dream: Dream
	@State private var task: Task<Void, Error>?
	@FocusState private var isFocused: Bool

	var body: some View {
		VStack {
			Form {
				Section("What was your dream?") {
					TextField("Dream title", text: $dream.title, axis: .vertical)
						.focused($isFocused)
				}
				
				Section("Describe your dream") {
					TextField("Dream details", text: $dream.details, axis: .vertical)
				}
				
				Section {
					LabeledContent("Intensity") {
						Slider(value: $dream.intensity) {
							Text("Intensity: \(dream.intensity.formatted())")
						} minimumValueLabel: {
							Image(systemName: "moon.zzz")
						} maximumValueLabel: {
							Image(systemName: "flame")
						}
					}
					
					DatePicker("Date", selection: $dream.date)
				}
			}
			.scrollContentBackground(.hidden)
			.navigationBarBackButtonHidden(true)
			.onChange(of: dream.title, indexDream)
			.onChange(of: dream.details, indexDream)
			.background(Color.bg)
			.toolbar { BackButton() }
		}
		.onAppear {
			if dream.title.isEmpty {
				isFocused = true
			}	
		}
	}
	
	func indexDream() {
		task?.cancel()
		
		task = Task {
			try await Task.sleep(for: .seconds(3))
			print("Indexing current dream")
			try await CSSearchableIndex.default().indexAppEntities([dream.entity])
		}
	}
}

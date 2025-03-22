//
//  DreamEditor.swift
//  Dreamcatcher
//

import CoreSpotlight
import SwiftUI

struct DreamEditor: View {
    @Bindable var dream: Dream
	@State private var task: Task<Void, Error>?

    var body: some View {
        Form {
            Section("Describe your dream") {
                TextField("Dream details", text: $dream.details, axis: .vertical)
            }

            Section("Extra details") {
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
        .navigationTitle($dream.title)
        .navigationBarTitleDisplayMode(.inline)
		.onChange(of: dream.title, indexDream)
		.onChange(of: dream.details, indexDream)
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

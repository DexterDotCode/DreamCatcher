//
//  DreamEditor.swift
//  Dreamcatcher
//

import SwiftUI

struct DreamEditor: View {
    @Bindable var dream: Dream

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
    }
}

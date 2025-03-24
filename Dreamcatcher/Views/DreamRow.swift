//
//  DreamRow.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 24/03/25.
//

import SwiftUI

struct DreamRow: View {
	var dream: String
	var date: Date
	var intensity: Double
	
    var body: some View {
		VStack(alignment: .leading) {
			Text(dream.isEmpty ? "Wild dream..." : dream)
				.foregroundStyle(dream.isEmpty ? Color.primary.opacity(0.5) : Color.primary)
				.font(.headline)
				.fontWeight(.medium)
		}
    }
}

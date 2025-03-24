//
//  Dream.swift
//  Dreamcatcher
//

import Foundation
import SwiftData

@Model
class Dream {
    var uniqueID = UUID()
    var title: String = ""
    var details: String = ""
	var intensity: Double = 0.0
	var date: Date = Date.now 
	
	var entity: DreamEntity {
		DreamEntity(id: uniqueID, title: title, details: details, date: date, intensity: intensity)
	}

	init(title: String = "", details: String = "", intensity: Double = 0.0, date: Date = .now) {
        self.title = title
        self.details = details
        self.intensity = intensity
        self.date = date
    }
}

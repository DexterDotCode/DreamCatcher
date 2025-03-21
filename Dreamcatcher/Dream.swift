//
//  Dream.swift
//  Dreamcatcher
//

import Foundation
import SwiftData

@Model
class Dream {
    var uniqueID = UUID()
    var title: String
    var details: String
    var intensity: Double
    var date: Date

    init(title: String, details: String, intensity: Double, date: Date) {
        self.title = title
        self.details = details
        self.intensity = intensity
        self.date = date
    }
}

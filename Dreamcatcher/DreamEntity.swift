//
//  DreamEntity.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents
import CoreSpotlight

struct DreamEntity: IndexedEntity {
	var id: UUID
	var title: String
	var details: String
	var date: Date
	var intensity: Double
	
	var attributeSet: CSSearchableItemAttributeSet {
		let attributesSet = defaultAttributeSet
		attributesSet.contentDescription = details
		attributesSet.addedDate = date
		return attributesSet
	}
	
	static let typeDisplayRepresentation: TypeDisplayRepresentation = "Dream"
	static let defaultQuery = DreamEntityQuery()
	
	var displayRepresentation: DisplayRepresentation {
		DisplayRepresentation(title: "\(title)", image: .init(systemName: "sparkles"))
	}
}


struct DreamEntityQuery: EnumerableEntityQuery {
	@Dependency var dataController: DataController
	
	func allEntities() async throws -> [DreamEntity] {
		try await dataController.dreamEntities()
	}
	
	func entities(for identifiers: [UUID]) async throws -> [DreamEntity] {
		try await dataController.dreamEntities(matching: #Predicate {
			identifiers.contains($0.uniqueID)
		})
	}
}

//
//  DreamEntity.swift
//  Dreamcatcher
//
//  Created by Tanish Mittal on 22/03/25.
//

import AppIntents


struct DreamEntity: IndexedEntity {
	var id: UUID
	var title: String
	var details: String
	
	static let typeDisplayRepresentation: TypeDisplayRepresentation = "Dream"
	static let defaultQuery = DreamEntityQuery()
	
	var displayRepresentation: DisplayRepresentation {
		DisplayRepresentation(stringLiteral: title)
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

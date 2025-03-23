//
//  DataController.swift
//  Dreamcatcher
//

import Foundation
import SwiftData

@Observable @MainActor
class DataController {
	var modelContext: ModelContext
    var path = [Dream]()
    var searchText = ""
	
	init(modelContainer: ModelContainer) {
		modelContext = ModelContext(modelContainer)
	}
	
	func dreams(
		matching predicate: Predicate<Dream> = #Predicate { _ in true },
		sortBy: [SortDescriptor<Dream>] = [SortDescriptor(\.date, order: .reverse)],
		limit: Int? = nil
	) throws -> [Dream] {
		var dreamDescriptor = FetchDescriptor<Dream>(predicate: predicate, sortBy: sortBy)
		dreamDescriptor.fetchLimit = limit
		return try modelContext.fetch(dreamDescriptor)
	}
	
	func dreamEntities(
		matching predicate: Predicate<Dream> = #Predicate { _ in true },
		sortBy: [SortDescriptor<Dream>] = [SortDescriptor(\.date, order: .reverse)],
		limit: Int? = nil
	) throws -> [DreamEntity] {
		try dreams(matching: predicate, sortBy: sortBy, limit: limit).map(\.entity)
	}
	
	func dreamCount(
	matching predicate: Predicate<Dream> = #Predicate { _ in true }
	) throws -> Int {
		let dreamDescriptor = FetchDescriptor<Dream>(predicate: predicate)
		return try modelContext.fetchCount(dreamDescriptor)
	}
	
	func select(entity: DreamEntity) throws {
		let id = entity.id
		
		let results = try dreams(matching: #Predicate {
			$0.uniqueID == id
		})
		
		if let first = results.first {
			path = [first]
		}
	}
}

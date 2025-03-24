//
//  DreamList.swift
//  Dreamcatcher
//

import AppIntents
import SwiftData
import SwiftUI
import CoreSpotlight

struct DreamList: View {
	@Environment(\.modelContext) private var modelContext
    @Query private var dreams: [Dream]
	@AppStorage("suggestIntent") var suggestIntent = true
	@State private var dreamToDelete: Dream?
	@State private var isShowingDeleteAlert = false
	@State private var hasBeenDeleted = false

    var body: some View {
        List {
			Section {
				ForEach(dreams) { dream in
					NavigationLink(value: dream) {
						DreamRow(dream: dream.title, date: dream.date, intensity: dream.intensity)
							.swipeActions(edge: .trailing, allowsFullSwipe: true) {
								Button {
									dreamToDelete = dreams.first(where: {$0.id == dream.id})
									isShowingDeleteAlert = true
								} label: {
									Label("Delete", systemImage: "trash")
								}
								.tint(Color.red)
							}
							.contextMenu {
								Button(role: .destructive) {
									dreamToDelete = dreams.first(where: {$0.id == dream.id})
									isShowingDeleteAlert = true
								} label: {
									Label("Delete", systemImage: "trash")
								}
							}
					}
				}
			}
			.listRowBackground(Color.clear)
			.listSectionSeparator(.hidden, edges: .top)
			
        }
		.listStyle(.plain)
		.listRowSpacing(10)
		.alert("Delete Dream", isPresented: $isShowingDeleteAlert) {
			Button("Delete", role: .destructive, action: dreamDelete)
			Button("Cancel", role: .cancel) { }
		} message: {
			Text("Are you sure you want to delete this dream?")
		}
		.sensoryFeedback(.success, trigger: hasBeenDeleted)
		.task(indexDreams)
    }
	
	func dreamDelete() {
		modelContext.delete(dreamToDelete!)
		isShowingDeleteAlert = false
		hasBeenDeleted.toggle()
	}

    init(searchText: String) {
        _dreams = Query(filter: #Predicate {
            if searchText.isEmpty {
                true
            } else {
                $0.title.localizedStandardContains(searchText)
                || $0.details.localizedStandardContains(searchText)
            }
        }, sort: \.date, order: .reverse)
    }
	
	func indexDreams() async {
		print("Indexing all dreams")
		try? await CSSearchableIndex.default().indexAppEntities(dreams.map(\.entity))
	}
}


#Preview {
	DreamList(searchText: "")
}

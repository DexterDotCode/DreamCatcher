//
//  DreamList.swift
//  Dreamcatcher
//

import AppIntents
import SwiftData
import SwiftUI
import CoreSpotlight

struct DreamList: View {
    @Query private var dreams: [Dream]
	
	@AppStorage("suggestIntent") var suggestIntent = true

    var body: some View {
        List {
			Section {
				ForEach(dreams) { dream in
					NavigationLink(dream.title, value: dream)
				}
			} footer: {
				VStack {
					ShortcutsLink()
					SiriTipView(intent: AddToRecentDreamIntent(), isVisible: $suggestIntent)
				}
			}
        }
		.task(indexDreams)
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

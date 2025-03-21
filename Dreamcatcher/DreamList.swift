//
//  DreamList.swift
//  Dreamcatcher
//

import SwiftData
import SwiftUI

struct DreamList: View {
    @Query private var dreams: [Dream]

    var body: some View {
        List {
            ForEach(dreams) { dream in
                NavigationLink(dream.title, value: dream)
            }
        }
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
}

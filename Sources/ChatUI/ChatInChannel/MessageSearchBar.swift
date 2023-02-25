//
//  MessageSearchBar.swift
//  
//
//  Created by Jaesung Lee on 2023/02/15.
//

import SwiftUI

// TODO: Not current scope
struct MessageSearchBar: View {
    @State private var searchText: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .xSmall
                .foregroundColor(.secondary)
            
            TextField("Search messages...", text: $searchText)
                .textFieldStyle(.plain)
        }
        .padding(.horizontal, 8)
        .frame(height: 36)
        .background {
            Color(.secondarySystemBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}


/**
 MessageList {... }
 .searchable(.visible)
 
 // search icon appears on the toolbar (navigation trailing)
 // When tap the icon -> search bar appears
 // shows all messages include search text
 */

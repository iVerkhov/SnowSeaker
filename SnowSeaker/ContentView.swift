//
//  ContentView.swift
//  SnowSeaker
//
//  Created by Игорь Верхов on 31.03.2024.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortOrder: SortOrder = .default
    @State private var showingsortOptions = false
    
    enum SortOrder: String, CaseIterable {
        case `default` = "Default"
        case alphabetical = "Alphabetical"
        case byCountry = "By country"
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    var sortedResorts: [Resort] {
        switch sortOrder {
        case .alphabetical: return filteredResorts.sorted { $0.name < $1.name }
        case .byCountry: return filteredResorts.sorted { $0.country < $1.country }
        default: return filteredResorts
        }
    }
    
    var body: some View {
        NavigationSplitView {
            Text(sortOrder.rawValue)
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                        }
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red.gradient)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        ForEach(SortOrder.allCases, id: \.self) { sortOrder in
                            Text(sortOrder.rawValue)
                        }
                    }
                }
                Button("Sort", systemImage: "arrow.up.arrow.down") { showingsortOptions = true }
            }
            .confirmationDialog("Sort order", isPresented: $showingsortOptions) {
                Button("Default") { sortOrder = .default }
                Button("Alphabetical") { sortOrder = .alphabetical }
                Button("By country") { sortOrder = .byCountry }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}

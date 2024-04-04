//
//  Favorites.swift
//  SnowSeaker
//
//  Created by Игорь Верхов on 03.04.2024.
//

import SwiftUI

@Observable
class Favorites {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        resorts = []
    }
    
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.setValue(data, forKey: key)
        }
    }
}

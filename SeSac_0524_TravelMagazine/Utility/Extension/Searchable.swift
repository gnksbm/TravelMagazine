//
//  Searchable.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import Foundation

protocol Searchable {
    var searchKeyPath: KeyPath<Self, String> { get }
}

extension Array where Element: Searchable {
    func search(contain query: String) -> Self {
        filter { $0[keyPath: $0.searchKeyPath].contains(query) }
    }
    
    func search(equal query: String) -> Self {
        filter { $0[keyPath: $0.searchKeyPath] == query }
    }
}

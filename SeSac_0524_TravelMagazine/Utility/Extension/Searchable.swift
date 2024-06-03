//
//  Searchable.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import Foundation

protocol Searchable {
    associatedtype SearchKey: Hashable
    var searchKey: SearchKey { get }
}

extension Array where Element: Searchable {
    func search(
        contain query: String
    ) -> Self where Element.SearchKey == String {
        filter { $0.searchKey.contains(query) }
    }
    
    func search(equal query: Element.SearchKey) -> Self {
        filter { $0.searchKey == query }
    }
}

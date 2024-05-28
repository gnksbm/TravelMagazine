//
//  DateFormat.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/28/24.
//

import Foundation

enum DateFormat: String {
    private static var cachedStorage = [DateFormat: DateFormatter]()
    
    case magazineInput = "yyMMdd"
    case magazineOutput = "yy년 MM월 dd일"
    
    var formatter: DateFormatter {
        if let formatter = Self.cachedStorage[self] {
            return formatter
        } else {
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = self.rawValue
            Self.cachedStorage[self] = newFormatter
            return newFormatter
        }
    }
}

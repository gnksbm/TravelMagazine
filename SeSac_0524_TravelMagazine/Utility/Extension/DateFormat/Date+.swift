//
//  Date+.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/28/24.
//

import Foundation

extension Date {
    func formatted(dateFormat: DateFormat) -> String {
        dateFormat.formatter.string(from: self)
    }
}

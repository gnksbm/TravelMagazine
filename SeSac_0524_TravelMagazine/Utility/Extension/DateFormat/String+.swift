//
//  String+.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/28/24.
//

import Foundation

extension String {
    func formatted(dateFormat: DateFormat) -> Date? {
        dateFormat.formatter.date(from: self)
    }
}

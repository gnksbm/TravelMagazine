//
//  Magazine.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/24/24.
//

import Foundation

struct Magazine {
    let title: String
    let subtitle: String
    let photo_image: String
    let date: String
    let link: String
    
    var formattedDate: String? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyMMdd"
        guard let formatted = dateformatter.date(from: date) else { return nil }
        dateformatter.dateFormat = "yy년 MM월 dd일"
        return dateformatter.string(from: formatted)
    }
}

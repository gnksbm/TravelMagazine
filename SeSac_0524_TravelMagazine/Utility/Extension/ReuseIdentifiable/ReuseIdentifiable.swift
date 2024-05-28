//
//  ReuseIdentifiable.swift
//  SeSac_0528
//
//  Created by gnksbm on 5/28/24.
//

import UIKit

protocol ReuseIdentifiable {
    static var identifier: String { get }
}

extension ReuseIdentifiable {
    static var identifier: String {
        String(describing: Self.self)
    }
}

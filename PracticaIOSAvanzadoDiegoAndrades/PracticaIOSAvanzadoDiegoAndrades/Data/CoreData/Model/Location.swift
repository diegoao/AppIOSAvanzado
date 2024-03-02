//
//  Location.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 2/3/24.
//

import Foundation

struct Location: Decodable, Hashable {
    let id: String?
    let latitude: String?
    let longitude: String?
    let date: String?
    let hero: Hero?

}

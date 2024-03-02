//
//  Hero.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 2/3/24.
//

import Foundation

struct Hero: Decodable, Hashable {
    let id: String?
    let name: String?
    let description: String?
    let photo: String?
    let favorite: Bool?
}

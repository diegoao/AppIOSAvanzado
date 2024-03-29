//
//  Transformation.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 2/3/24.
//

import Foundation

struct Transformation: Decodable, Hashable  {
    let id: String?
    let name: String?
    let description: String?
    let photo: String?
    let hero: Hero?
    
}

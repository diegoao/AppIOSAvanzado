//
//  NetworkError.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 28/2/24.
//

import Foundation


enum NetworkError: Error, Equatable {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decoding
}

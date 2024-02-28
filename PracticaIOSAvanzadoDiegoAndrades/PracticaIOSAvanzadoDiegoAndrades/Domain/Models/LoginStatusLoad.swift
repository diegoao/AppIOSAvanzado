//
//  LoginStatusLoad.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 28/2/24.
//

import Foundation

enum LoginStatusLoad {
    case loading (_ isloading: Bool)
    case loaded
    case showErrorEmail(_ error: String?)
    case showErrorPassWord(_ error: String?)
    case errorNetwork(_ error: String)

}

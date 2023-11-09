//
//  User.swift
//  testing4
//
//  Created by Admin on 8.11.23.
//

import Foundation

struct User: Codable {
    var firstName = ""
    var lastName = ""
    var email = ""
    var birthDate = Date()
    var isExtraNapkins = false
    var frequentRefills = false
}

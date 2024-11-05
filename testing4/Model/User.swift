//
//  User.swift
//  testing4
//
//  Created by Anton Polovoy on 8.11.24.
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

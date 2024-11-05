//
//  Date+Ext.swift
//  testing4
//
//  Created by Alex Polovoy on 5.11.24.
//

import Foundation

extension Date {
    
    var sixYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -6, to: Date())!
    }
    
    var oneHundredTenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -110, to: Date())!
    }
}

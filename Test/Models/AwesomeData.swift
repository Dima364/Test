//
//  AwesomeData.swift
//  Test
//
//  Created by Дмитрий Помин on 14.04.2026.
//

import Foundation

nonisolated
struct AwesomeData: Hashable, Comparable, Codable {
    let awesomeField: Int
    let date: Date
    let id: String
    
    static func == (lhs: AwesomeData, rhs: AwesomeData) -> Bool {
        lhs.date == rhs.date
    }
    
    static func < (lhs: AwesomeData, rhs: AwesomeData) -> Bool {
        lhs.date < rhs.date
    }
}

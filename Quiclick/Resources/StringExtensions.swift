//
//  StringExtensions.swift
//  a-via
//

import Foundation

extension String {
    var firstUppercased: String {
        prefix(1).uppercased() + dropFirst()
    }
}

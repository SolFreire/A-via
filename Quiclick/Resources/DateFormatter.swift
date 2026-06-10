//
//  DateFormatter.swift
//  a-via
//
//  Created by Soraia Freire Batista on 08/06/26.
//
import SwiftUI

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier:"pt-BR")
    formatter.dateFormat = "dd 'de' MMMM 'de' yyyy"
    return formatter
}()

let monthFormatterString: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier:"pt-BR")
    formatter.dateFormat = "MMMM 'de' yyyy"
    return formatter
}()

let dayFormatterString: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier:"pt-BR")
    formatter.dateFormat = "dd"
    return formatter
}()
extension String {
    var firstUppercased: String {
        prefix(1).uppercased() + dropFirst()
    }
}

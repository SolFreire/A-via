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

func paceformatter(_ pace: Double) -> String {
    return String(format: "%02d:%02d", Int(pace), Int((pace.truncatingRemainder(dividingBy: 1)) * 60))
}

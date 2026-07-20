//
//  CalendarViewModel.swift
//  a-via
//
//  Created by Soraia Freire Batista on 09/06/26.
//
import SwiftUI
import Foundation
import SwiftData


@MainActor
@Observable
final class CalendarViewModel{
    
    func groupWorkouts(_ workouts : [WorkoutModel]) -> [[WorkoutModel]]{
        let sorted = workouts.sorted{ $0.date < $1.date}
        let keyFormatter = DateFormatter()
        keyFormatter.dateFormat = "yyyy-MM"
        
        return Dictionary(grouping: sorted) {
            keyFormatter.string(from: $0.date)
        }.sorted { $0.value[0].date > $1.value[0].date }
        .map(\.value)
    }

    
}

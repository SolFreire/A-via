//
//  WeeklyTemplateViewModel.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 06/05/26.
//
import SwiftUI
import Foundation
import SwiftData

@MainActor
@Observable
final class WeeklyTemplateViewModel{

    let calendar = Calendar.current

    /// Distance (in meters) a runner must reach for each distance template to unlock.
    private let distanceRequirements: [TypeTemplateView: Double] = [
        .distance5km: 5000,
        .distance10km: 10000,
        .distance15km: 15000,
        .distance21km: 21000,
        .distance42km: 42000
    ]

    /// Duration (in hours) a runner must reach for each time template to unlock.
    private let timeRequirements: [TypeTemplateView: Double] = [
        .timeregular: 0,
        .time2hours: 2
    ]

    /// The fastest (lowest) pace across the given workouts, in min/km.
    func bestPace(in workouts: [WorkoutModel]) -> Double {
        workouts.map(\.pace).min() ?? 100.0
    }

    /// The longest single-run duration across the given workouts.
    func bestTime(in workouts: [WorkoutModel]) -> TimeInterval {
        workouts.map(\.duration).max() ?? 0
    }

    /// The longest single-run distance across the given workouts, in meters.
    func bestDistance(in workouts: [WorkoutModel]) -> Double {
        workouts.map(\.distance).max() ?? 0
    }

    /// A distance template is unlocked once the runner's best distance reaches its requirement.
    func isDistanceTemplateUnlocked(_ template: TypeTemplateView, bestDistance: Double) -> Bool {
        guard let required = distanceRequirements[template] else { return false }
        return bestDistance >= required
    }

    /// A time template is unlocked once the runner's best time (in hours) reaches its requirement.
    func isTimeTemplateUnlocked(_ template: TypeTemplateView, bestTimeInHours: Double) -> Bool {
        guard let required = timeRequirements[template] else { return false }
        return bestTimeInHours >= required
    }

    func weeklyTotalDistance(weeklyWorkouts: [WorkoutModel]) -> Int {
        weeklyWorkouts.reduce(0) { $0 + Int($1.distance) / 1000 }
    }

}

extension Date {
    var isCurrentWeek: Bool {
        let week = Calendar.current.dateInterval(of: .weekOfYear, for: Date())
        let firstDayOfWeek = week?.start ?? Date()
        return self >= firstDayOfWeek
    }
}

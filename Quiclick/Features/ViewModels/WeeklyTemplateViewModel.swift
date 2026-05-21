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
//    var bestTimeViewType : BestTimeCardView.ViewType = .regular
//    var bestDistanceViewType : ViewType = .distanceregular

    
    func WeekBestPace(weeklyWorkouts:[WorkoutModel]) -> Double {
        var bestPace: Double = 100.0
        for workout in weeklyWorkouts{
            if(workout.pace < bestPace){
                bestPace = workout.pace
            }
        }
        return bestPace
    }
    
    func WeekBestTime(weeklyWorkouts:[WorkoutModel]) -> TimeInterval {
        var bestTime : TimeInterval = 0.0
        for workout in weeklyWorkouts{
            if(workout.duration > bestTime){
                bestTime = workout.duration
            }
        }
//        if(bestTime >= 7200){
//            bestTimeViewType = .twohoursrunning
//        }
        return bestTime
    }
    
    func WeekBestDistance(weeklyWorkouts:[WorkoutModel]) -> Double {
        var bestDistance : Double = 0.0
        for workout in weeklyWorkouts{
            if(workout.distance > bestDistance){
                bestDistance = workout.distance
            }
        }
//        if(bestDistance >= 5000){
//            bestDistanceViewType = .distance5km
//        }
        
        return bestDistance
    }
    
    func weeklyTotalDistance(weeklyWorkouts:[WorkoutModel]) -> Int {
        var totalDistance: Int = 0
        for workout in weeklyWorkouts {
            totalDistance += Int(workout.distance)/1000
        }
        return totalDistance
    }
    
}
extension Date {
    var isCurrentWeek: Bool {
        let week = Calendar.current.dateInterval(of: .weekOfYear, for: Date())
        let firstDayOfWeek = week?.start ?? Date()
        return self >= firstDayOfWeek
    }
}

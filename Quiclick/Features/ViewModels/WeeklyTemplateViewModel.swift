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
        
        return bestTime
    }
    
    func BestDistance(Workouts:[WorkoutModel]) -> Double {
        var bestDistance : Double = 0.0
        for workout in Workouts{
            if(workout.distance > bestDistance){
                bestDistance = workout.distance
            }
        }
        
        return bestDistance
    }
    
    func templateDistanceBlocked (viewTypeTemplate: TypeTemplateView, bestDistance: Double) -> Bool {
        var templateIsBlocked: Bool = false
        
        let templatesFree: [TypeTemplateView : Double] = [.distance5km:5000, .distance10km:10000, .distance15km:15000, .distance21km:21000, .distance42km:42000]
        
        for (template, distance) in templatesFree {
            if(viewTypeTemplate == template && bestDistance >= distance){
                templateIsBlocked = true
            }
        }
        
        return templateIsBlocked
    }
    
    func templateTimeBlocked (viewTypeTemplate: TypeTemplateView, bestTime: Double) -> Bool {
        var templateIsBlocked: Bool = false
        
        let templatesFree: [TypeTemplateView : Double] = [.timeregular:0, .time2hours:2]
        
        for (template, time) in templatesFree {
            if(viewTypeTemplate == template && bestTime >= time){
                templateIsBlocked = true
            }
        }
        
        return templateIsBlocked
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

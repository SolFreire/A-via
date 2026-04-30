//
//  WorkoutMapper.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 24/04/26.
//

import SwiftUI
import HealthKit


 func mapToWorkoutModel(_ workout: HKWorkout) -> WorkoutModel{
    let distanceSample = workout.statistics(for: HKQuantityType(.distanceWalkingRunning))
    let distance = distanceSample?.sumQuantity()?.doubleValue(for: HKUnit.meter()) ?? 0.0
    return WorkoutModel(
        id  : workout.uuid,
        date: workout.startDate,
        duration: workout.duration, //secs(TimeInterval)
        distance: distance //meters
    )
}

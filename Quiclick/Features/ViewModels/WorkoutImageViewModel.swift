//
//  WorkoutImageViewModel.swift
//  a-via
//
//  Created by Soraia Freire Batista on 22/06/26.
//
import SwiftData
import SwiftUI

@MainActor
func syncWorkoutImageToCloud( workout: WorkoutModel, context: ModelContext) throws{
    guard let image = workout.imageData else {
        return
    }
    
    let workoutID = workout.id
    
    let descriptor =
        FetchDescriptor<WorkoutModelCloud>(
            predicate: #Predicate<WorkoutModelCloud> {
                $0.id == workoutID
            }
        )
    
    if let existing =
        try context.fetch(descriptor).first {
        existing.imageData = image
    } else {
        let remote = WorkoutModelCloud(
            id: workout.id,
            imageData: image
        )
        context.insert(remote)
    }
    try context.save()
}

func recoverImagesFromCloud(
    context: ModelContext
)throws{
    let cloud =
        try context.fetch(FetchDescriptor<WorkoutModelCloud>())
    
    let cloudMap = Dictionary(
            uniqueKeysWithValues:
                cloud.map{($0.id, $0.imageData)}
        )
    
    for workout in try context.fetch(FetchDescriptor<WorkoutModel>()) {
        guard workout.imageData == nil else {
            continue
        }
        
        workout.imageData = cloudMap[workout.id] ?? nil
    }
    try context.save()
}

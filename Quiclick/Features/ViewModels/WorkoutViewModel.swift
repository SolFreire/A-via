//
//  HKViewModel.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 24/04/26.
//

import Foundation
import HealthKit
import Observation
import SwiftData


@Observable
@MainActor
class WorkoutViewModel{
    var isAuthorized: Bool = false
    var errorMessage: String?
    
    func requestAuthorization(context: ModelContext) async{
        do{
            let success = try await HKManager.shared.requestAuthorization()
                self.isAuthorized = success
            if success{
                await syncWorkoutData(context: context )
            }
        } catch{
            self.errorMessage = error.localizedDescription
        }
    }
    func syncWorkoutData(context: ModelContext) async{
        do{
            let hkWorkouts = try await HKManager.shared.readWorkouts()
            let existing = try context.fetch(FetchDescriptor<WorkoutModel>())
            let existingIDs = Set(existing.map{$0.id})
            let newWorkouts = hkWorkouts.filter{
                !existingIDs.contains($0.uuid)
            }
            
            for hk in newWorkouts{
                let model = mapToWorkoutModel(hk)
                context.insert(model)
            }
            try context.save()
        } catch{
            self.errorMessage = error.localizedDescription
        }
    }
    
}

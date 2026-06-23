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
    var isLoading: Bool = true
    var isDenied: Bool = false
    
    func requestAuthorization(context: ModelContext) async{
        isLoading = true
        do{
            let success = try await HKManager.shared.requestAuthorization()
                self.isAuthorized = success
            if success {
                await syncWorkoutData(context: context )
            }
        } catch{
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    func syncWorkoutData(context: ModelContext) async{
        do{
            let hkWorkouts = try await HKManager.shared.readWorkouts()
            let existing = try context.fetch(FetchDescriptor<WorkoutModel>())
            let existingIDs = Set(existing.map{$0.id})
            
            for hk in hkWorkouts{
                guard !existingIDs.contains(hk.uuid)
                else { continue }
                    
                context.insert(
                    mapToWorkoutModel(hk)
                )
            }
            try context.save()
            
            try recoverImagesFromCloud(context: context)
            
        } catch{
            self.errorMessage = error.localizedDescription
        }
    }
    
}

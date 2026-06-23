//
//  HKManager.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 24/04/26.
//

import Foundation
import HealthKit
import Observation


@Observable
@MainActor
class HKManager{
    static let shared = HKManager()
    private let store = HKHealthStore()
    let calendar = Calendar.current
    
    private init() {}
    
    func requestAuthorization() async throws -> Bool {
        guard HKHealthStore.isHealthDataAvailable() else {
            return false
        }
        let readTypes: Set<HKObjectType> = [
            HKObjectType.workoutType(),
        ]
        
        try await store.requestAuthorization(toShare: [], read: readTypes)

        return true
    }
    
    private func workoutSamplesPredicate() -> NSPredicate {
        
        let runningPredicate = HKQuery.predicateForWorkouts(
            with: .running
        )
        
        return NSCompoundPredicate(
            andPredicateWithSubpredicates: [runningPredicate]
        )
    }
    
    func readWorkouts() async throws ->[HKWorkout]{
        
        let query = HKSampleQueryDescriptor(
            predicates:[.workout(workoutSamplesPredicate())],
            sortDescriptors:[SortDescriptor(\.startDate, order: .reverse)])
        
        return try await query.result(for:store)
    
    }
}

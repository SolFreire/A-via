//
//  WorkoutModel.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 24/04/26.
//
import SwiftUI
import SwiftData

@Model
class WorkoutModel: Identifiable{
    
    var id : UUID
    var date: Date
    var duration: TimeInterval
    var distance: Double
    var pace : Double
    var imageData: Data?
    
    
    init(id: UUID,date: Date, duration: TimeInterval, distance: Double) {
        self.id = id
        self.date = date
        self.duration = duration
        self.distance = distance // meters
        self.pace = (Double(duration)/60.0)/(distance/1000) //minutes per km 
        self.imageData = nil
    }
    
    
    var image:UIImage?{
        imageData.flatMap{
            UIImage(data:$0)
        }
    }
}


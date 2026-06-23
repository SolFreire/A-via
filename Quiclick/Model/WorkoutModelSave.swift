//
//  WorkoutModelSave.swift
//  a-via
//
//  Created by Soraia Freire Batista on 22/06/26.
//

import SwiftUI
import SwiftData

@Model
class WorkoutModelCloud: Identifiable{
    
    var id : UUID?
    var imageData: Data?
    
    
    init(id: UUID,imageData : Data) {
        self.id = id
        self.imageData = imageData
    }
    
    
}

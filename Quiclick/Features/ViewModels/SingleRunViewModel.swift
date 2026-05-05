//
//  EditImageViewModel.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 28/04/26.
//
import SwiftUI
import Foundation
import SwiftData


@MainActor
@Observable

final class SingleRunViewModel {
    
    var type: SingleRunView.ViewType = .noImage
    var pickerImage: UIImage?
    var pickerImageData: Data?
    
    func readData(workout: WorkoutModel){
        if(workout.imageData != nil){
            type = .regular
        }
    }
    
    func startEditing(with image: Data) {
        pickerImage = UIImage(data:image)
        pickerImageData = image
        type = .edit
    }
    
    func confirmEdit(workout: WorkoutModel, context: ModelContext, ImageView: some View) {
        pickerImageData = renderFinalImage(view: ImageView)
        workout.imageData = pickerImageData
        type = .regular
        
        do{
            try context.save()
        }catch{
            print("Erro ao Salvar")
            
        }
    }
    
    func cancelEditing(workout: WorkoutModel) {
        pickerImage = nil
        if(workout.imageData == nil){
            type = .noImage
        }else{
            type = .regular
        }
    }
    
    func renderFinalImage(view: some View) -> Data? {
        let renderer = ImageRenderer(content: view)
        
        renderer.scale = UIScreen.main.scale
        
        if let uiImage = renderer.uiImage {
            return uiImage.pngData()
        }
        
        return nil
    }
}

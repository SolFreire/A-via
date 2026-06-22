//
//  EditImageViewModel.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 28/04/26.
//
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
    var resizedImage : Data?
    var cropFormat: CropFormat = .story
    var cropScale: CGFloat = 1
    var cropOffset: CGSize = .zero
    
    func readData(workout: WorkoutModel){
        if(workout.imageData != nil){
            type = .regular
        }
    }
    
    func startResize(with image: Data) {
        pickerImage = UIImage(data:image)
        pickerImageData = image
        type = .resize
    }
    
    func selectFormat(_ format: CropFormat) {
        cropFormat = format
        cropScale = 1
        cropOffset = .zero
    }
    
    func confirmResize(){
        guard let image = pickerImage,
              let result = crop(image,
                                cropSize: frameSize(for: cropFormat,
                                                    maxWidth: 318, maxHeight: 600),
                                scale: cropScale,
                                offset: cropOffset,
                                export: cropFormat.exportSize)
        else { return }

        resizedImage = result.pngData()
        startEditing(with: resizedImage!)
    }
    func cancelResize(){
        pickerImage = nil
        pickerImageData = nil
        type = .noImage
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
    
    
    func discardImage(workout: WorkoutModel, context: ModelContext){
        pickerImage = nil
        workout.imageData = nil
        pickerImageData = nil
        type = .noImage
        do{
            try context.save()
        }catch{
            print("Erro ao Salvar")
            
        }
    }
    
    func cancelEditing(workout: WorkoutModel) {
        pickerImage = nil
        pickerImageData = nil
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

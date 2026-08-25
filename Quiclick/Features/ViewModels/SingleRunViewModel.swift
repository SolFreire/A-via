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
        if let image = workout.image {
            // Recupera o formato a partir da imagem já salva para que
            // reabrir a edição não volte ao formato padrão.
            cropFormat = CropFormat.matching(image.size)
            type = .regular
        }
    }

    func startResize(with image: Data) {
        pickerImage = UIImage(data:image)
        pickerImageData = image
        cropFormat = .story
        cropScale = 1
        cropOffset = .zero
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
                                cropSize: cropFormat.previewSize,
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
        // Renderiza o preview na escala que reproduz o tamanho de exportação
        // do formato escolhido, preservando o redimensionamento até o save.
        pickerImageData = renderFinalImage(view: ImageView, scale: cropFormat.exportScale)
        workout.imageData = pickerImageData
        type = .regular
        
        do{
            try context.save()
        }catch{
            print("Erro ao Salvar")
            
        }
        do{
            try syncWorkoutImageToCloud(workout: workout, context: context)
        }catch{print("cloud save error")}
        
        
        do{
            let cloud = try context.fetch(
                FetchDescriptor<WorkoutModelCloud>()
            )
            
            print("CLOUD COUNT:", cloud.count)
            print(cloud.map(\.id))
            
        }catch{print("Error to find Images In cloude")}


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
    
    func renderFinalImage(view: some View, scale: CGFloat? = nil) -> Data? {
        let renderer = ImageRenderer(content: view)

        renderer.scale = scale ?? UIScreen.main.scale

        if let uiImage = renderer.uiImage {
            return uiImage.pngData()
        }
        
        return nil
    }
}

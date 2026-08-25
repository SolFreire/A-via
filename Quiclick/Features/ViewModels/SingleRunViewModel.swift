//
//  SingleRunViewModel.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 28/04/26.
//

import SwiftUI
import Foundation
import SwiftData
import PhotosUI

@MainActor
@Observable

final class SingleRunViewModel {

    var type: SingleRunView.ViewType = .noImage
    /// Falha a ser mostrada ao usuário. Um `print` no catch some no console
    /// e deixa a pessoa achando que salvou.
    var errorMessage: String?
    var pickerItem: PhotosPickerItem?
    var pickerImage: UIImage?
    var cropFormat: CropFormat = .story
    var cropScale: CGFloat = 1
    var cropOffset: CGSize = .zero

    // Estado da edição. Vive aqui, e não na View, para existir em um lugar
    // só: enquanto a View mantinha cópias próprias, cada botão da toolbar
    // precisava lembrar de zerar as duas metades na mão.
    var selectedStickers: [Sticker] = []
    var activeCategory: StickerCategory = .metrics

    func readData(workout: WorkoutModel){
        if let image = workout.image {
            // Recupera o formato a partir da imagem já salva para que
            // reabrir a edição não volte ao formato padrão.
            cropFormat = CropFormat.matching(image.size)
            type = .regular
        }
    }

    /// Carrega a foto escolhida no PhotosPicker e entra no redimensionamento.
    /// O carregamento é responsabilidade da ViewModel: a View só declara o
    /// picker e observa o resultado.
    func loadPickedImage() async {
        guard let pickerItem,
              let data = try? await pickerItem.loadTransferable(type: Data.self)
        else { return }

        startResize(with: data)
    }

    func startResize(with image: Data) {
        pickerImage = UIImage(data:image)
        cropFormat = .story
        cropScale = 1
        cropOffset = .zero
        type = .resize
    }

    // MARK: - Stickers

    func addSticker(named name: String) {
        selectedStickers.append(Sticker(name: name))
    }

    func deselectAllStickers() {
        selectedStickers.forEach { $0.isSelected = false }
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
                                export: cropFormat.exportSize),
              let resized = result.pngData()
        else {
            errorMessage = "Não foi possível recortar a imagem."
            return
        }

        startEditing(with: resized)
    }
    func cancelResize(){
        resetEditingState()
        type = .noImage
    }
    func startEditing(with image: Data) {
        pickerImage = UIImage(data:image)
        type = .edit
    }
    
    /// Recebe a imagem já renderizada pela View. A ViewModel decide o que
    /// salvar; a View decide como desenhar.
    func confirmEdit(workout: WorkoutModel, context: ModelContext, imageData: Data?) {
        guard let imageData else {
            errorMessage = "Não foi possível gerar a imagem editada."
            return
        }

        workout.imageData = imageData
        selectedStickers = []
        type = .regular

        do{
            try context.save()
            try WorkoutImageRepository.syncToCloud(workout: workout, context: context)
        }catch{
            errorMessage = "Não foi possível salvar a imagem: \(error.localizedDescription)"
        }
    }


    func discardImage(workout: WorkoutModel, context: ModelContext){
        resetEditingState()
        workout.imageData = nil
        type = .noImage
        do{
            try context.save()
        }catch{
            errorMessage = "Não foi possível remover a imagem: \(error.localizedDescription)"
        }
    }
    
    func cancelEditing(workout: WorkoutModel) {
        resetEditingState()
        if(workout.imageData == nil){
            type = .noImage
        }else{
            type = .regular
        }
    }

    /// Zera tudo o que pertence a uma sessão de edição. Um único ponto de
    /// limpeza evita que um caminho de saída esqueça metade do estado.
    private func resetEditingState() {
        pickerItem = nil
        pickerImage = nil
        selectedStickers = []
    }
}

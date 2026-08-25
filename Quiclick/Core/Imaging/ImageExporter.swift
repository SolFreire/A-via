//
//  ImageExporter.swift
//  a-via
//

import SwiftUI

/// Renderiza uma View SwiftUI em PNG.
///
/// Mora na camada de serviço, e não numa ViewModel, porque quem conhece
/// tipos de View é a camada de View. Uma ViewModel que recebe `some View`
/// como parâmetro inverte a direção da dependência do MVVM e passa a ser
/// impossível de testar sem SwiftUI.
@MainActor
enum ImageExporter {

    /// - Parameter scale: fator de pontos para pixels. Passe o `exportScale`
    ///   do formato para obter exatamente o tamanho de exportação; omita
    ///   para usar a escala da tela.
    static func png(from view: some View, scale: CGFloat? = nil) -> Data? {
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale ?? UIScreen.main.scale
        return renderer.uiImage?.pngData()
    }
}

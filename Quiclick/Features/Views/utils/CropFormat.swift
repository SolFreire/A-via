//
//  EditToolView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 02/06/26.
//
import SwiftUI

enum CropFormat: String, CaseIterable, Identifiable {
    case story
    case feed

    var id: String { rawValue }

    var ratio: CGSize {
        switch self {
        case .story:  return CGSize(width: 9, height: 16)
        case .feed:   return CGSize(width: 4, height: 5)
        }
    }

    var label: String {
        switch self {
        case .story:  return "Story"
        case .feed:   return "Feed"
        }
    }

    var icon: String {
        switch self {
        case .story:  return "rectangle.dashed"
        case .feed:   return "square.dashed"
        }
    }
    
    var iconRotation: Angle {
        switch self {
        case .story: return .degrees(90)
        case .feed:  return .degrees(0)
        }
    }

    var exportSize: CGSize {
        switch self {
        case .story:  return CGSize(width: 1080, height: 1920)
        case .feed:   return CGSize(width: 1080, height: 1350)
        }
    }
}

extension CropFormat {

    /// Espaço disponível na tela para o preview de redimensionamento e edição.
    static let previewMaxWidth: CGFloat = 318
    static let previewMaxHeight: CGFloat = 476

    /// Tamanho do preview respeitando a proporção do formato.
    /// Usado no recorte, na edição e na renderização final, para que
    /// o que o usuário vê seja exatamente o que é salvo.
    var previewSize: CGSize {
        frameSize(for: self,
                  maxWidth: CropFormat.previewMaxWidth,
                  maxHeight: CropFormat.previewMaxHeight)
    }

    /// Fator que leva o preview ao tamanho final de exportação.
    var exportScale: CGFloat {
        exportSize.width / previewSize.width
    }

    /// Formato cuja proporção mais se aproxima da imagem informada.
    /// Permite reabrir a edição de uma imagem já salva sem perder o formato.
    static func matching(_ size: CGSize) -> CropFormat {
        guard size.width > 0, size.height > 0 else { return .story }
        let imageRatio = size.width / size.height
        return allCases.min {
            abs($0.ratio.width / $0.ratio.height - imageRatio)
            < abs($1.ratio.width / $1.ratio.height - imageRatio)
        } ?? .story
    }
}

func frameSize(for format: CropFormat, maxWidth: CGFloat, maxHeight: CGFloat) -> CGSize {
    let r = format.ratio
    var w = maxWidth
    var h = w * r.height / r.width
    if h > maxHeight {
        h = maxHeight
        w = h * r.width / r.height
    }
    return CGSize(width: w, height: h)
    

}


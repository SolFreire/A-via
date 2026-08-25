//
//  StickerCatalog.swift
//  a-via
//

import Foundation

/// Catálogo de stickers disponíveis, agrupados por categoria.
///
/// Era um dicionário declarado dentro da View, com um array `tabs` separado
/// só para garantir a ordem das abas — dicionário não tem ordem. Como enum
/// CaseIterable, a ordem é a da declaração e não há como uma aba existir sem
/// conteúdo correspondente.
enum StickerCategory: String, CaseIterable, Identifiable {
    case metrics = "Métricas"
    case places = "Locais"
    case accessories = "Acessórios"

    var id: String { rawValue }

    var title: String { rawValue }

    var stickerNames: [String] {
        switch self {
        case .metrics:
            return ["Metrics", "MetricsH", "StickerMedal"]
        case .places:
            return ["StickerCoco", "StickerIracema", "StickerUnifor", "StickerIguatemi"]
        case .accessories:
            return ["StickerTenis", "StickerOculos", "StickerGarrafa", "StickerRelogio"]
        }
    }
}

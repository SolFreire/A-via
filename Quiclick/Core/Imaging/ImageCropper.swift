//
//  ImageCropper.swift
//  a-via
//

import UIKit

/// Recorta a imagem conforme o enquadramento escolhido no preview.
///
/// Estava declarada como função global dentro de `CropableImageView.swift`,
/// um arquivo de View. Manipulação de pixels não depende de SwiftUI e não
/// pertence à camada de View: aqui ela é testável sem renderizar nada.
///
/// - Parameters:
///   - cropSize: área visível do preview, em pontos.
///   - scale: zoom aplicado pelo usuário.
///   - offset: deslocamento aplicado pelo usuário, em pontos.
///   - export: tamanho final desejado, em pixels.
func crop(_ image: UIImage,
          cropSize: CGSize,
          scale: CGFloat,
          offset: CGSize,
          export: CGSize) -> UIImage? {

    let normalized = image.normalizedUp()
    guard let cg = normalized.cgImage else { return nil }
    let iw = CGFloat(cg.width), ih = CGFloat(cg.height)

    let baseFill = max(cropSize.width / iw, cropSize.height / ih)
    let pxPerPoint = 1 / (baseFill * scale)

    let cropW = cropSize.width  * pxPerPoint
    let cropH = cropSize.height * pxPerPoint
    let originX = (-cropSize.width/2  - offset.width)  * pxPerPoint + iw/2
    let originY = (-cropSize.height/2 - offset.height) * pxPerPoint + ih/2

    let rect = CGRect(x: originX, y: originY, width: cropW, height: cropH)
        .integral
        .intersection(CGRect(x: 0, y: 0, width: iw, height: ih))

    guard let cropped = cg.cropping(to: rect) else { return nil }

    let format = UIGraphicsImageRendererFormat.default()
    format.scale = 1
    return UIGraphicsImageRenderer(size: export, format: format).image { _ in
        UIImage(cgImage: cropped).draw(in: CGRect(origin: .zero, size: export))
    }
}

extension UIImage {
    /// Redesenha a imagem com orientação `.up`, para que o recorte trabalhe
    /// no mesmo sistema de coordenadas em que o preview foi exibido.
    func normalizedUp() -> UIImage {
        guard imageOrientation != .up else { return self }
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

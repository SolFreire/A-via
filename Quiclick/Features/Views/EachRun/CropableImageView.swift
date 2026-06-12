//
//  CropableImageView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 11/06/26.
//

import SwiftUI

struct CroppableImage: View {
    let image: UIImage
    let cropSize: CGSize
    @Binding var scale: CGFloat
    @Binding var offset: CGSize

    @GestureState private var pinch: CGFloat = 1
    @GestureState private var drag: CGSize = .zero

    var body: some View {
        Color.black
            .overlay {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(scale * pinch)
                    .offset(
                        x: offset.width + drag.width,
                        y: offset.height + drag.height
                    )
            }
            .frame(width: cropSize.width, height: cropSize.height)
            .clipped()
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .updating($drag) { v, s, _ in s = v.translation }
                    .onEnded { v in
                        offset.width  += v.translation.width
                        offset.height += v.translation.height
                    }
            )
            .simultaneousGesture(
                MagnificationGesture()
                    .updating($pinch) { v, s, _ in s = v }
                    .onEnded { v in scale = max(1, scale * v)
                    print("x: \(offset.width + drag.width), y: \(offset.height + drag.height), ofsw: \(offset.width), ofsh: \(offset.height), scale: \(scale), pinch: \(pinch)")}
            )
    }
}

extension UIImage {
    func normalizedUp() -> UIImage {
        guard imageOrientation != .up else { return self }
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

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

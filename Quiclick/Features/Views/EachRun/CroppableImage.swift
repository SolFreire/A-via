//
//  CroppableImage.swift
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
        
        let liveScale = scale * pinch
        let liveOffset = clampedOffset(
            CGSize(width: offset.width + drag.width,
                   height: offset.height + drag.height),
                    scale: liveScale
        )

        Color.black
            .overlay {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(scale * pinch)
                    .offset(
                        liveOffset
                    )
            }
            .frame(width: cropSize.width, height: cropSize.height)
            .clipped()
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .updating($drag) { v, s, _ in s = v.translation }
                    .onEnded { v in
                        let combined = CGSize(width: offset.width + v.translation.width,height: offset.height + v.translation.height)
                        offset = clampedOffset(combined, scale: scale)
                    }
            )
            .simultaneousGesture(
                MagnificationGesture()
                    .updating($pinch) { v, s, _ in s = v }
                    .onEnded { v in
                        scale = max(1, scale * v)
                        offset = clampedOffset(offset, scale: scale)}
            )
    }
    
    private func clampedOffset(_ proposed: CGSize, scale: CGFloat) -> CGSize {
        let imgSize = image.size
        let fill = max(cropSize.width / imgSize.width,
                       cropSize.height / imgSize.height)

        let displayedW = imgSize.width  * fill * scale
        let displayedH = imgSize.height * fill * scale

        let maxX = max(0, (displayedW - cropSize.width)  / 2)
        let maxY = max(0, (displayedH - cropSize.height) / 2)

        return CGSize(
            width:  min(max(proposed.width,  -maxX), maxX),
            height: min(max(proposed.height, -maxY), maxY)
        )
    }
}


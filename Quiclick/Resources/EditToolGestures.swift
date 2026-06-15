//
//  Gesrtures.swift
//  a-via
//
//  Created by Soraia Freire Batista on 02/06/26.
//
import SwiftUI

func magnificationGesture(sticker:Sticker) -> some Gesture{
    MagnifyGesture()
        .onChanged{value in
            let newScale = min(max(0.5, sticker.lastScale * value.magnification), 1.5)
            sticker.scale = newScale
        }
        .onEnded{_ in
            sticker.lastScale = sticker.scale
        }
}
func rotationGesture(sticker:Sticker) -> some Gesture{
    RotationGesture()
        .onChanged{value in
            sticker.rotation = sticker.lastRotation + value
        }
        .onEnded{_ in
            sticker.lastRotation = sticker.rotation
        }
}
func dragGesture(sticker:Sticker) -> some Gesture{
    DragGesture()
        .onChanged{value in
            sticker.position = value.location
        }
}

func dragAsMagnify(sticker:Sticker) -> some Gesture{
    DragGesture()
        .onChanged{ value in
            let delta = -value.translation.height / (75/2)
            let newScale = min(max(0.5, sticker.lastScale + delta), 1.5)
            sticker.scale = newScale
        }
        .onEnded{ _ in
            sticker.lastScale = sticker.scale
        }
}

func dragasRotate(sticker:Sticker) -> some Gesture{
    DragGesture()
        .onChanged{ value in
            let base = sticker.lastRotation
            let center = sticker.position
//            let startAngle = atan2(Double(value.startLocation.y - center.y),
        }
        .onEnded{ _ in
            sticker.lastRotation = sticker.rotation
        }
}

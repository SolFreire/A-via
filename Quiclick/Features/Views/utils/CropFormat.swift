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


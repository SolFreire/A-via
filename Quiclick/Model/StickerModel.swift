//
//  StickerModel.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 04/05/26.
//
import Observation
import SwiftUI

@Observable
class Sticker{
    let id = UUID()
    let name: String
    
    var offset: CGSize = CGSize()
    var position = CGPoint(x:200,y:200)
    var scale : CGFloat = 1.0
    var rotation : Angle = .zero
    
    var lastScale : CGFloat = 1.0
    var lastRotation : Angle = .zero
    
    init(name: String) {
        self.name = name
    }
}


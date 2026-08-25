//
//  CropGuideView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 12/06/26.
//
import SwiftUI

struct CropGuideView: View {
    var format : CropFormat

    var body: some View {
        // A moldura acompanha a área de recorte real do formato,
        // então o que fica dentro dela é o que será exportado.
        let size = format.previewSize

        Rectangle()
            .stroke(Color.white, lineWidth: 2)
            .frame(width: size.width, height: size.height)
            .foregroundColor(Color.clear)
            .overlay{
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0.0), count: 3), spacing: 0){
                    ForEach(0..<9, id: \.self){ _ in
                        Rectangle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            .frame(width: size.width / 3, height: size.height / 3)
                            .foregroundColor(Color.clear)
                    }
                }
            }
    }
}
#Preview{
    CropGuideView(format: .feed)
}

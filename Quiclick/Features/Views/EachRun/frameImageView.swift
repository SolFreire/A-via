//
//  frameImageView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 12/06/26.
//
import SwiftUI

struct frameImageView: View {
    var format : CropFormat
    var body: some View {
        if format == .story {
            Rectangle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 318, height: 600)
                .foregroundColor(Color.clear)
                .overlay{
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0.0), count: 3), spacing: 0){
                        ForEach(0..<9, id: \.self){ _ in
                            Rectangle()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 106, height: 200)
                                .foregroundColor(Color.clear)
                        }
                    }

                }
        }
        else{
            Rectangle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 318, height: 396)
                .foregroundColor(Color.clear)
                .overlay{
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0.0), count: 3), spacing: 0){
                        ForEach(0..<9, id: \.self){ _ in
                            Rectangle()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 106, height: 132)
                                .foregroundColor(Color.clear)
                        }
                    }

                }
            
        }
    }
}
#Preview{
    frameImageView(format: .feed)
}

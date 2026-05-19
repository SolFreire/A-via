//
//  TemplateShareView.swift
//  Quiclick
//
//  Created by Luiz Henrique da Silva Bezerra on 19/05/26.
//

import SwiftUI

struct TemplateShareView: View {
    
    @State private var showShareSheet: Bool = false
    @State var image: UIImage?
    
    var body: some View {
        VStack (alignment: .leading) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 318, height: 476)
                    .clipped()
                    .background(Color.black)
                    .cornerRadius(15)
                    
            } else {
                Text("No image selected")
            }
        }
        .padding()
        .toolbar {
            if let image = image {
                Button {
                    showShareSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(Color.black)
                }
                .imageShareSheet(isPresented: $showShareSheet, image: image)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
    
#Preview {
    TemplateShareView(image: UIImage(named: "TimeCardImage")!)
}

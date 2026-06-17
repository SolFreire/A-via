//
//  TemplateShareView.swift
//  Quiclick
//
//  Created by Luiz Henrique da Silva Bezerra on 19/05/26.
//

import SwiftUI

struct TemplateShareView: View {
    
    @State private var viewModel = SingleRunViewModel()
    @State private var showShareSheet: Bool = false
    @Environment(\.dismiss) var dismiss
    let imageTemplate: any View
    
    
    
    var saveNewImage:UIImage? {
        viewModel.renderFinalImage(view: imageTemplate).flatMap{
            UIImage(data:$0)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center) {
                
                AnyView(imageTemplate)
                
            }
            .toolbar {
                
                ToolbarItem {
                    if let saveNewImage = saveNewImage {
                        Button {
                            showShareSheet = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .imageShareSheet(isPresented: $showShareSheet, image: saveNewImage)
                    }
                }
                
                ToolbarItem (placement: .title) {
                    Text("Compartilhe")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem (placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            
        }
        .padding()
    }
}
    
#Preview {
    TemplateShareView(
        imageTemplate: Text("")
    )
}

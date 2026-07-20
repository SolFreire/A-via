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
    let toShareTamplate: ToShareTemplate
    
    var imageView: some View {
        ImageTemplateView(toShareTemplate: toShareTamplate)
    }
    
    var saveNewImage: UIImage? {
        viewModel.renderFinalImage(view: imageView).flatMap{
            UIImage(data:$0)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center) {
                imageView
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
        toShareTamplate: ToShareTemplate(
            template: .bestpace,
            shareMode: .feed,
            bestPace: 5.4,
            bestTime: TimeInterval()
        )
    )
}

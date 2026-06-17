//
//  ImageShareView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 04/05/26.
//

import Foundation
import SwiftUI
import LinkPresentation

struct ImageShareSheet: UIViewControllerRepresentable {
    let images: [UIImage]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let activityViewController = UIActivityViewController(activityItems: images, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.assignToContact]
        
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension View {
    func imageShareSheet(
        isPresented: Binding<Bool>,
        images: [UIImage]
    ) -> some View {
        return sheet(isPresented: isPresented, content: { ImageShareSheet(images: images) } )
    }
    
    func imageShareSheet(
        isPresented: Binding<Bool>,
        image: UIImage
    ) -> some View {
        return sheet(isPresented: isPresented, content: { ImageShareSheet(images: [image]) } )
    }
    
    func placeholder(icon: String) -> some View {
        Rectangle()
            .foregroundColor(.gray.opacity(0.2))
            .overlay {
                Image(systemName: icon)
                    .foregroundStyle(.white)
                    .font(.system(size: 50))
            }
    }
}



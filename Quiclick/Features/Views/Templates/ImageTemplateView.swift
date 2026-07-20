//
//  ImageTemplateView.swift
//  a-via
//
//  Created by Luiz Henrique da Silva Bezerra on 18/06/26.
//

import SwiftUI

enum ShareMode: CaseIterable {
    case story, feed
}

struct ToShareTemplate: Identifiable {
    let id: UUID = UUID()
    let template: TypeTemplateView
    let shareMode: ShareMode
    let bestPace: Double
    let bestTime: TimeInterval
}

struct ImageTemplateView: View {
    let toShareTemplate: ToShareTemplate
    
    var body: some View {
        switch toShareTemplate.shareMode {
        case .feed:
            shareFeed
        case .story:
            shareStory
        }
    }
    
    var shareStory: some View{
        Image(toShareTemplate.template.image)
            .resizable()
            .scaledToFill()
            .frame(width: 257, height: 456)
            .clipped()
            .cornerRadius(12)
            .overlay {
                if (toShareTemplate.template == .bestpace) {
                    imageSection(metricViewType: toShareTemplate.template)
                        .offset(y: 130)
                }
                else if (toShareTemplate.template == .timeregular) {
                    imageSection(metricViewType: toShareTemplate.template)
                        .offset(y: -150)
                }
                else {
                    imageSection(metricViewType: toShareTemplate.template)
                }
            }
    }
    
    var shareFeed: some View {
        Image(toShareTemplate.template.image)
            .frame(width: 240, height: 300)
            .scaledToFill()
            .clipped()
            .cornerRadius(12)
            .overlay {
                if (toShareTemplate.template == .bestpace) {
                    imageSection(metricViewType: toShareTemplate.template)
                        .offset(y: 99)
                }
                else if (toShareTemplate.template == .timeregular) {
                    imageSection(metricViewType: toShareTemplate.template)
                        .offset(y: -99)
                    
                }
                else {
                    imageSection(metricViewType: toShareTemplate.template)
                }
            }
        }
    
    @ViewBuilder
    func imageSection(metricViewType: TypeTemplateView) -> some View {
        switch metricViewType {
        case .timeregular:
            VStack {
                Text("Uau!\nSua corrida mais\nlonga durou")
                Text("\(floor((toShareTemplate.bestTime)/60).formatted()) minutos.")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .font(.system(size: 22, weight: .bold))
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .dynamicTypeSize(.large)
            
            
        case .bestpace:
            VStack {
                Text("Pace de ")
                Text("\((toShareTemplate.bestPace).formatted(.number.precision(.fractionLength(2))))" + " min/km")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Rápido como quem\nperdeu o ônibus")
            }
            .font(.system(size: 22, weight: .bold))
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .dynamicTypeSize(.large)
            
        default:
            Text("")
        }
    }
}

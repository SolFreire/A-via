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
    let metricViewType: ViewType?
    let titleMetric: String
    let image: UIImage?
    
    let bestPace: Double?
    let weeklyDistance: Int?
    let bestTime: TimeInterval?
    
    var saveNewImage:UIImage?{
        viewModel.renderFinalImage(view: imageSection()).flatMap{
            UIImage(data:$0)
        }
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(titleMetric)
                .font(.largeTitle)
                .bold()
            
            imageSection()
        }
        .padding()
        .toolbar {
            if let saveNewImage = saveNewImage {
                Button {
                    showShareSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(Color.black)
                }
                .imageShareSheet(isPresented: $showShareSheet, image: saveNewImage)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        
        Spacer()
    }
    
    @ViewBuilder
    func imageSection() -> some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 318, height: 476)
                .clipped()
                .background(Color.black)
                .cornerRadius(15)
                .overlay(alignment: .center) {
                    switch metricViewType {
                        
                    case .timeregular:
                        VStack {
                            Text("Uau!\nSua corrida mais\nlonga durou")
                            Text("\(floor((bestTime ?? 0)/60).formatted()) minutos.")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 23, weight: .bold))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .offset(y: -119)
                        .foregroundStyle(.white)
                        
                    case .weeklydistance:
                        VStack {
                            Text("Essa semana você correu")
                                .font(.system(size: 23, weight: .bold))
                            Text("\(weeklyDistance ?? 0) km")
                                .font(.system(size: 80, weight: .bold))
                                .fontWeight(.bold)
                        }
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .offset(y: -115)
                        .foregroundStyle(.white)
                        
                    case .bestpace:
                        VStack {
                            Text("Pace de ")
                            Text("\((bestPace ?? 0.00).formatted(.number.precision(.fractionLength(2))))")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("Rápido como quem\nperdeu o ônibus")
                        }
                        .font(.system(size: 23, weight: .bold))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .offset(y: 119)
                        .foregroundStyle(.white)
                        
                    default:
                        Text("")
                    }
                }
                
        } else {
            Text("No image selected")
        }
    }
}
    
#Preview {
    TemplateShareView(
        metricViewType: .timeregular,
        titleMetric: "Métricas",
        image: UIImage(named: "TimeRegularImage"),
        bestPace: 1.43,
        weeklyDistance: 34,
        bestTime: 1800
    )
}

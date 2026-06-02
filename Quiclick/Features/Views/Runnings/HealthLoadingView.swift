//
//  HealthLoadingView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 07/05/26.
//

import SwiftUI

struct HealthLoadingView: View {
    @State private var ring1Progress: CGFloat = 0
    @State private var ring2Progress: CGFloat = 0
    @State private var ring3Progress: CGFloat = 0
    @State private var dotOpacities: [CGFloat] = [0.3, 0.3, 0.3]

    let ringColors: [(track: Color, fill: Color)] = [
        (Color(.systemGray5), Color(red: 0.98, green: 0.25, blue: 0.42)),
        (Color(.systemGray5), Color(red: 0.30, green: 0.78, blue: 0.29)),
        (Color(.systemGray5), Color(red: 0.23, green: 0.74, blue: 0.94)),
    ]

    let radii: [CGFloat] = [52, 37, 24]
    let lineWidths: [CGFloat] = [9, 8, 7]

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            ZStack {
                ForEach(0..<3, id: \.self) { i in
                    let r = radii[i]
                    let w = lineWidths[i]
                    let progress = [ring1Progress, ring2Progress, ring3Progress][i]

                    Circle()
                        .stroke(ringColors[i].track, lineWidth: w)
                        .frame(width: r * 2, height: r * 2)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            ringColors[i].fill,
                            style: StrokeStyle(lineWidth: w, lineCap: .round)
                        )
                        .frame(width: r * 2, height: r * 2)
                        .rotationEffect(.degrees(-90))
                }
            }
            .frame(width: 120, height: 120)

            VStack(spacing: 6) {
                Text("Buscando seus Exercícios de Corrida")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("Conectando ao Apple Health")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onAppear { startAnimations() }
    }

    private func startAnimations() {
        animateRings()
    }

    private func animateRings() {
        let duration = 2.0

        withAnimation(.easeInOut(duration: duration * 0.6)) {
            ring1Progress = 1
        }
        withAnimation(.easeInOut(duration: duration * 0.6).delay(0.1)) {
            ring2Progress = 1
        }
        withAnimation(.easeInOut(duration: duration * 0.6).delay(0.2)) {
            ring3Progress = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 0.9) {
            ring1Progress = 0
            ring2Progress = 0
            ring3Progress = 0
            animateRings()
        }
    }

}

#Preview {
    HealthLoadingView()
}

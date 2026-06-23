//
//  OnBoardingView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 16/06/26.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboarding: Bool
    var body: some View {
        TabView{
            Onb0View()
            Onb1View()
            Onb2View()
            Onb3View()
            Onb4View(isOnboarding: $isOnboarding)
        }
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical)

    }
}

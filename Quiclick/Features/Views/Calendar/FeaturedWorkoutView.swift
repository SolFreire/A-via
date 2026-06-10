//
//  FeaturedWorkoutView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 10/06/26.
//

import SwiftUI

struct FeaturedWorkoutView: View {

    let workout: WorkoutModel

    var body: some View {

        ZStack(alignment: .topLeading) {

            if let image = workout.image {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()

            }

            Text(dayFormatterString.string(from: workout.date))
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.limeCalendarNumbers)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 1)
        }
        .frame(height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//
//  CalendarItemView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 09/06/26.
//

import SwiftUI

struct CalendarItemView: View {

    let workout: WorkoutModel
    
    private let itemSize: CGFloat = 81

    var body: some View {

        Group {
            if let image = workout.image {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: itemSize, maxWidth: .infinity, minHeight: itemSize, maxHeight: .infinity)
                    .clipped()

            } else {

                RoundedRectangle(cornerRadius: 10)
                    .fill(.blankCard)
                    .overlay {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                            .offset(x:0, y: 4)
                    }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(alignment: .topLeading) {
            Text(dayFormatterString.string(from: workout.date))
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.limeCalendarNumbers)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 1)
        }
    }
}

#Preview{
    CalendarItemView(workout: WorkoutModel(id: UUID(), date: Date(), duration: 2222, distance: 1234))
}

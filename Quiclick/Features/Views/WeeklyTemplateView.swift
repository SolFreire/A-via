//
//  WeeklyTemplateView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 27/04/26.
//
import SwiftUI
import SwiftData

struct WeeklyTemplateView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \WorkoutModel.id)
    private var workouts: [WorkoutModel]
    
    var body: some View{
        
        VStack(alignment: .leading){
            Text("Semana de Treinos")
                .font(.title)
                .bold()
            VStack{
                WeeklyCounterCardView()
                HStack(){
                    BestDistanceCardView()
                    BestTimeCardView()
                }
                BestPaceCardView()
            }
        }
        .padding()
    }
}


#Preview {
    WeeklyTemplateView()
}

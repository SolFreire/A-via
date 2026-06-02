//
//  StickerView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 02/06/26.
//

import SwiftUI

struct StickerView: View {
    @Binding var selectedStickers : [Sticker]
    let index: Int
    let sticker : Sticker
    let workout: WorkoutModel
    var body: some View {
        let scaledSize = 75 * sticker.scale
        let scaledSizeMetrics = 150 * sticker.scale
        let relativeHeight = -((scaledSizeMetrics/2) * 1.732)
        if sticker.name == "Metrics"{
            ZStack{
                VStack(alignment: .center, spacing: 12){
                    VStack(alignment: .center, spacing: 2){
                        Text("Duração")
                            .font(.system(size: 20 * sticker.scale , weight: .semibold))
                            .foregroundColor(Color.white)
                        Text(formatDuration(workout.duration))
                            .font(.system(size: 32 * sticker.scale, weight: .bold))
                            .foregroundColor(Color.white)
                    }
                    VStack(alignment: .center, spacing: 2){
                        Text("Distância")
                            .font(.system(size: 20 * sticker.scale , weight: .semibold))
                            .foregroundColor(Color.white)
                        Text("\((workout.distance/1000).formatted()) km")
                            .font(.system(size: 32 * sticker.scale, weight: .bold))
                            .foregroundColor(Color.white)
                    }
                    VStack(alignment: .center, spacing: 2){
                        Text("Pace")
                            .font(.system(size: 20 * sticker.scale, weight: .semibold))
                            .foregroundColor(Color.white)
                        Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                            .font(.system(size: 32 * sticker.scale, weight: .bold))
                            .foregroundColor(Color.white)
                    }
                    Image("a-viaSticker")
                        .resizable()
                        .frame(width:40 * sticker.scale, height: 40*sticker.scale)
                        .offset(x: -6, y: 0)
                }
                .border(sticker.isSelected ? Color.gray.opacity(0.5) : Color.clear)
                .overlay {
                    if(sticker.isSelected){
                        Circle()
                            .frame(width: 30,height: 30)
                            .foregroundStyle(.gray)
                            .overlay{
                                Image(systemName:"arrow.down.left.arrow.up.right")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .offset(x: scaledSizeMetrics  / 2, y: relativeHeight)
                            .gesture(
                                dragAsMagnify(sticker: sticker)
                            )
                        
                        
                        
                        Button{
                            selectedStickers.remove(at: index)
                        } label: {
                            Image(systemName:"trash")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .frame(width: 24,height: 24)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.circle)
                        .tint(.gray)
                        .padding()
                        .foregroundColor(.white)
                        .offset(x: -scaledSizeMetrics  / 2, y: relativeHeight)
                        
                    }
                }
            }
            .frame(width: scaledSizeMetrics , height: scaledSizeMetrics )
            .rotationEffect(sticker.rotation)
            .position(sticker.position)
            .gesture(
                dragGesture(sticker:sticker)
                    .simultaneously(with: magnificationGesture(sticker:sticker))
                    .simultaneously(with: rotationGesture(sticker:sticker))
                    .simultaneously(with: TapGesture().onEnded{sticker.isSelected.toggle()})
            )
        }
        else{
            ZStack{
                Image(sticker.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: scaledSize,height: scaledSize)
                    .border(sticker.isSelected ? Color.gray.opacity(0.5) : Color.clear)
                    .overlay {
                        if(sticker.isSelected){
                            Circle()
                                .frame(width: 30,height: 30)
                                .foregroundStyle(.gray)
                                .overlay{
                                    Image(systemName:"arrow.down.left.arrow.up.right")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .offset(x: scaledSize / 2, y: -scaledSize/2)
                                .gesture(
                                    dragAsMagnify(sticker:sticker)
                                )
                                

                            
                            Button{
                                selectedStickers.remove(at: index)
                            } label: {
                                Image(systemName:"trash")
                                    .font(.system(size: 12, weight: .bold))
                            }
                                .frame(width: 24,height: 24)
                                .buttonStyle(.borderedProminent)
                                .buttonBorderShape(.circle)
                                .tint(.gray)
                                .padding()
                                .foregroundColor(.white)
                                .offset(x: -scaledSize / 2, y: -scaledSize/2)

                        }
                    }
            
                
            }
                .rotationEffect(sticker.rotation)
                .position(sticker.position)
                .gesture(
                    dragGesture(sticker:sticker)
                        .simultaneously(with: magnificationGesture(sticker: sticker))
                        .simultaneously(with: rotationGesture(sticker:sticker))
                        .simultaneously(with: TapGesture().onEnded{sticker.isSelected.toggle()})
                )
        }
    }
}


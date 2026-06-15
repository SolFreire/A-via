//
//  StickerView.swift
//  a-via
//
//  Created by Soraia Freire Batista on 02/06/26.
//

import SwiftUI

struct StickerView: View {
    @Binding var selectedStickers : [Sticker]
    @State private var changeColor: Bool = false
    let index: Int
    let sticker : Sticker
    let workout: WorkoutModel
    var body: some View {
        let scaledSize = 75 * sticker.scale
        let scaledSizeMetrics = 150 * sticker.scale
        let relativeHeight = -((scaledSizeMetrics/2) * 1.732)
        if sticker.name == "Metrics"{
            ZStack{
                MetricsVerticalSticker
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
                            .offset(x: -scaledSizeMetrics  / 2, y: -relativeHeight)
                            
                            Button{
                                changeColor.toggle()
                            } label: {
                                Image(systemName:"pencil")
                                    .font(.system(size: 12, weight: .bold))
                            }
                                .frame(width: 24,height: 24)
                                .buttonStyle(.borderedProminent)
                                .buttonBorderShape(.circle)
                                .tint(.gray)
                                .padding()
                                .foregroundColor(.white)
                                .offset(x: -scaledSizeMetrics / 2, y: relativeHeight)
                            if(changeColor){
                                VStack(){
                                    Button{
                                        sticker.color = .white
                                    } label: {
                                        Circle()
                                            .tint(.white)
                                            .frame(width: 24)
                                    }
                                    
                                    Button{
                                        sticker.color = .black
                                    } label: {
                                        Circle()
                                            .tint(.black)
                                            .frame(width: 24)
                                    }
                                    
                                    Button{
                                        sticker.color = .limeButtons
                                    } label: {
                                        Circle()
                                            .tint(.limeButtons)
                                            .frame(width: 24)
                                    }
                                }
                                    .offset(x: -(scaledSizeMetrics / 2) - 40, y: relativeHeight)
                            }
                            
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
        else if sticker.name == "MetricsH"{
            ZStack{
                MetricsHorizontalSticker
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
                            .offset(x: -scaledSizeMetrics  / 2, y: -relativeHeight)
                            
                            Button{
                                changeColor.toggle()
                            } label: {
                                Image(systemName:"pencil")
                                    .font(.system(size: 12, weight: .bold))
                            }
                                .frame(width: 24,height: 24)
                                .buttonStyle(.borderedProminent)
                                .buttonBorderShape(.circle)
                                .tint(.gray)
                                .padding()
                                .foregroundColor(.white)
                                .offset(x: -scaledSizeMetrics / 2, y: relativeHeight)
                            if(changeColor){
                                VStack(){
                                    Button{
                                        sticker.color = .white
                                    } label: {
                                        Circle()
                                            .tint(.white)
                                            .frame(width: 24)
                                    }
                                    
                                    Button{
                                        sticker.color = .black
                                    } label: {
                                        Circle()
                                            .tint(.black)
                                            .frame(width: 24)
                                    }
                                    
                                    Button{
                                        sticker.color = .limeButtons
                                    } label: {
                                        Circle()
                                            .tint(.limeButtons)
                                            .frame(width: 24)
                                    }
                                }
                                    .offset(x: -(scaledSizeMetrics / 2) - 40, y: relativeHeight)
                            }
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
                    .colorMultiply(sticker.color)
                    .frame(width: scaledSize,height: scaledSize)
                    .border(sticker.isSelected ? Color.gray.opacity(0.5) : Color.clear)
                    .overlay {
                        if(sticker.isSelected){
                            Circle()
                                .foregroundStyle(.gray)
                                .overlay{
                                    Image(systemName:"arrow.down.left.arrow.up.right")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 24,height: 24)
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
                                .offset(x: -scaledSize / 2, y: scaledSize/2)

                                Button{
                                    changeColor.toggle()
                                } label: {
                                    Image(systemName:"pencil")
                                        .font(.system(size: 12, weight: .bold))
                                }
                                    .frame(width: 24,height: 24)
                                    .buttonStyle(.borderedProminent)
                                    .buttonBorderShape(.circle)
                                    .tint(.gray)
                                    .padding()
                                    .foregroundColor(.white)
                                    .offset(x: -scaledSize / 2, y: -scaledSize/2)
                                Circle()
                                    .foregroundStyle(.gray)
                                    .overlay {
                                        Image(systemName: "arrow.clockwise")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 24, height: 24)
                                    .offset(x: scaledSize / 2, y: scaledSize / 2)
                                    .gesture(dragasRotate(sticker: sticker))

                                
                                if(changeColor){
                                    VStack(){
                                        Button{
                                            sticker.color = .white
                                        } label: {
                                            Circle()
                                                .tint(.white)
                                                .frame(width: 40)
                                        }
                                        
                                        Button{
                                            sticker.color = .black
                                        } label: {
                                            Circle()
                                                .tint(.black)
                                                .frame(width: 40)
                                        }
                                        
                                        Button{
                                            sticker.color = .limeButtons
                                        } label: {
                                            Circle()
                                                .tint(.limeButtons)
                                                .frame(width: 40)
                                        }
                                    }
                                        .offset(x: -(scaledSize / 2) - 40, y: -scaledSize/2)
                                }
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
    var MetricsVerticalSticker : some View{
        VStack(alignment: .center, spacing: 12){
            VStack(alignment: .center, spacing: 2){
                Text("Duração")
                    .font(.system(size: 20 * sticker.scale , weight: .semibold))
                    .foregroundColor(sticker.color)
                Text(formatDuration(workout.duration))
                    .font(.system(size: 32 * sticker.scale, weight: .bold))
                    .foregroundColor(sticker.color)
            }
            VStack(alignment: .center, spacing: 2){
                Text("Distância")
                    .font(.system(size: 20 * sticker.scale , weight: .semibold))
                    .foregroundColor(sticker.color)
                Text("\((workout.distance/1000).formatted()) km")
                    .font(.system(size: 32 * sticker.scale, weight: .bold))
                    .foregroundColor(sticker.color)
            }
            VStack(alignment: .center, spacing: 2){
                Text("Pace")
                    .font(.system(size: 20 * sticker.scale, weight: .semibold))
                    .foregroundColor(sticker.color)
                Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                    .font(.system(size: 32 * sticker.scale, weight: .bold))
                    .foregroundColor(sticker.color)
            }
            Image("a-viaSticker")
                .resizable()
                .frame(width:40 * sticker.scale, height: 40*sticker.scale)
                .offset(x: -6, y: 0)
                .foregroundColor(sticker.color)
                .colorMultiply(sticker.color)
        }
    }
    var MetricsHorizontalSticker : some View{
        HStack(alignment: .center, spacing: 12){
            VStack(alignment: .center, spacing: 2){
                Text("Duração")
                    .font(.system(size: 20 * sticker.scale , weight: .semibold))
                    .foregroundColor(sticker.color)
                Text(formatDuration(workout.duration))
                    .font(.system(size: 32 * sticker.scale, weight: .bold))
                    .foregroundColor(sticker.color)
            }
            VStack(alignment: .center, spacing: 2){
                Text("Distância")
                    .font(.system(size: 20 * sticker.scale , weight: .semibold))
                    .foregroundColor(sticker.color)
                Text("\((workout.distance/1000).formatted()) km")
                    .font(.system(size: 32 * sticker.scale, weight: .bold))
                    .foregroundColor(sticker.color)
            }
            VStack(alignment: .center, spacing: 2){
                Text("Pace")
                    .font(.system(size: 20 * sticker.scale, weight: .semibold))
                    .foregroundColor(sticker.color)
                Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                    .font(.system(size: 32 * sticker.scale, weight: .bold))
                    .foregroundColor(sticker.color)
            }
            Image("a-viaSticker")
                .resizable()
                .frame(width:40 * sticker.scale, height: 40*sticker.scale)
                .offset(x: -6, y: 0)
                .colorMultiply(sticker.color)
        }
    }
}


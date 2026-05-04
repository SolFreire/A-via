//
//  Testedrag.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 04/05/26.
//
import SwiftUI


struct Testedrag: View {
    
    @State var selectedStickers: [Sticker] = []
    
    var Stickers = ["StickerCoco", "StickerIracema" ,"StickerUnifor" ,"StickerIguatemi"]
    @State var selectedSticker = Sticker(name: "StickerCoco")
    @State var offset: CGSize = CGSize()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.red)
                    .scaledToFill()
                
//                ForEach(selectedStickers.indices, id:\.self){ index in
                    Image(selectedSticker.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75,height: 75)
                        .offset(offset)
                        .position(selectedSticker.position)

                    //                            .scaleEffect(selectedStickers[index].scale)
                    //                            .rotationEffect(selectedStickers[index].rotation)
                        .gesture(
                            DragGesture()
                                .onChanged{value in
                                    offset = value.translation
//                                    selectedSticker.position = value.location
                                    print(selectedSticker.position)
                                }
                        )

//                }
            
                }
            
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.gray.opacity(0.3))
                    .frame(width: 393, height: 262)
                
                VStack{
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: Array(repeating: .init(.flexible(), spacing: 6.0), count: 1)){
                            ForEach(Stickers, id:\.self){ sticker in
                                RoundedRectangle(cornerRadius: 6)
                                    .overlay{
                                        Image(sticker)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    .frame(width: 75,height: 75)
                                    .aspectRatio(contentMode: .fit)
                                    .onTapGesture {
                                        selectedStickers.append(Sticker(name:sticker))
                                    }
                            }
                        }
                        .foregroundColor(.gray)
                    }
                }.padding(30)
            }
        }
    }
}

#Preview {
    Testedrag()
}

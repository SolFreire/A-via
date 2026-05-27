//
//  SingleRunView.swift
//  Quiclick
//
//  Created by Soraia Freire Batista on 27/04/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct SingleRunView: View{
    
    enum ViewType {
        case regular, edit, noImage
    }
    
    @State private var viewModel = SingleRunViewModel()
    @Environment(\.modelContext) private var context
    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerImage: Data?
    @State var hasPictureSaved: Bool?
    @State var showImageSheet = false
    @State var selectedStickers : [Sticker] = []
    
    var Stickers = ["Metrics","a-viaSticker", "StickerCoco", "StickerIracema" ,"StickerUnifor" ,"StickerIguatemi", "StickerTenis", "StickerOculos", "StickerGarrafa", "StickerRelogio"]
    let workout: WorkoutModel
    let dateFormatter={
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
    var showsBackButton: Bool {
        if viewModel.type == .edit {
            return true
        } else {
            return false
        }
    }
    var body : some View{

        VStack {
            ScrollView(.vertical, showsIndicators: false){
                imageSection()
                
                if viewModel.type == .edit {
                    editSection
                } else {
                    infoSection
                }
            }
            }
            .toolbar {
                toolbarContent
            }
            .onChange(of: pickerItem){
                Task {
                    if let loaded = try? await pickerItem?.loadTransferable(type: Data.self){
                        pickerImage = loaded
                        viewModel.startEditing(with: pickerImage!)
                    }else{
                        print("Failed to load image")
                    }
                }
            }
            .navigationBarBackButtonHidden(showsBackButton)
            .toolbar(.hidden, for: .tabBar)
            .onAppear(){
                viewModel.readData(workout: workout)
            }
    }
    
    @ViewBuilder
    func imageSection() -> some View {
        Group {
            switch viewModel.type {
                
            case .noImage:
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    placeholder(icon: "photo.badge.plus")
                }
                
            case .edit:
                if(workout.imageData != nil){
                    if let image = workout.image {
                        ZStack{
                            
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                
                                ForEach(selectedStickers.indices, id:\.self){ index in
                                    StickerView(for: index)
                                }
                        }
                    }

                    
                }else{
                    if let image = viewModel.pickerImage {
                        ZStack{
                            Image(uiImage:image)
                                .resizable()
                                .scaledToFill()
                            
                            ForEach(selectedStickers.indices, id:\.self){ index in
                                StickerView(for: index)
                            }
                        }
                    }
                       
                }
                
            case .regular:
                if let image = workout.image {
                          Image(uiImage: image)
                              .resizable()
                              .scaledToFill()
                       }
            }
        }
        .frame(width: 318, height: 476)
        .clipped()
    }

    var infoSection: some View{
        VStack(alignment: .leading, spacing:-12){
                   Text(dateFormatter.string(from: workout.date))
                       .font(.title)
                       .fontWeight(.semibold)
                       .padding()
            VStack(alignment: .leading){
                ViewThatFits{
                    VStack(alignment: .leading, spacing: 8){
                        HStack(spacing:50){
                            
                            VStack(alignment: .leading, spacing: 8){
                                Text("Distância")
                                    .font(.body)
                                    .fontWeight(.medium)
                                Text("\((workout.distance/1000).formatted()) km")
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                            VStack(alignment: .leading, spacing: 8){
                                Text("Tempo")
                                    .font(.body)
                                    .fontWeight(.medium)
                                Text(formatDuration(workout.duration))
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Pace")
                                .font(.body)
                                .fontWeight(.medium)
                            Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                    }
                    .padding()
                    VStack(alignment: .leading,spacing: 8){
                        HStack{
                            VStack(alignment: .leading, spacing: 8){
                                Text("Distância")
                                    .font(.body)
                                    .fontWeight(.medium)
                                Text("\((workout.distance/1000).formatted()) km")
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                        }
                        HStack{
                            VStack(alignment: .leading, spacing: 8){
                                Text("Tempo")
                                    .font(.body)
                                    .fontWeight(.medium)
                                Text(formatDuration(workout.duration))
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                        }
                        HStack{
                            VStack(alignment: .leading, spacing: 8){
                                Text("Pace")
                                    .font(.body)
                                    .fontWeight(.medium)
                                Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                        }
                    }.padding(.horizontal)
                    
                }


            }
               }
               .frame(minWidth:318, alignment: .leading)
               .background(.gray.opacity(0.1))
               
        
    }
    
    var editSection: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.gray.opacity(0.3))
                .frame(maxWidth: 393, minHeight: 262, maxHeight: .infinity)
            
            VStack(alignment: .center){
                ScrollView(.horizontal) {
                    LazyHGrid(rows: Array(repeating: .init(.flexible(), spacing: 6.0), count: 2)){
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
                                    selectedStickers.forEach { $0.isSelected = false }
                                    selectedStickers.append(Sticker(name:sticker))
                                }
                            
                        }
                    }
                    .foregroundColor(.gray)
                }
            }.padding(30)
        }
    }

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        
        ToolbarItem(placement: .cancellationAction) {
            if viewModel.type == .edit {
                Button("Cancel", systemImage: "xmark") {
                    pickerItem = nil
                    pickerImage = nil
                    viewModel.cancelEditing(workout: workout)
                    selectedStickers = []
                }
            }
        }
        
        ToolbarItem(placement: .confirmationAction){
            if viewModel.type == .edit{
                Button("Done", systemImage: "checkmark"){
                    selectedStickers.forEach { $0.isSelected = false }
                    viewModel.confirmEdit(workout:workout, context: context, ImageView: imageSection())
                    selectedStickers = []
                }
            }
        }
        

        ToolbarItem(placement: .topBarTrailing) {
            
            if viewModel.type == .regular{
                
                Button {
                    viewModel.type = .edit
                } label: {
                    Image(systemName: "pencil")
                }
            }
            if viewModel.type == .edit{
                
                Button {
                    selectedStickers = []
                    viewModel.discardImage(workout: workout, context: context)
                } label: {
                    Image(systemName: "trash")
                }
            }
            
        }
        if #available(iOS 26.0, *) {
            ToolbarSpacer(.fixed, placement:.topBarTrailing)
        }
        ToolbarItem(placement: .topBarTrailing) {
            
            if viewModel.type == .regular{
                
                Button {
                    showImageSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .imageShareSheet(isPresented: $showImageSheet, image: workout.image!)
            }
            
        }
        
    }
    
    @ViewBuilder
    func StickerView(for index: Int) -> some View {
        let sticker = selectedStickers[index]
        if sticker.name == "Metrics" {
        MetricStickerViewRender(sticker: sticker, index: index, workout: workout)
        } else {
            let scaledSize = 75 * sticker.scale
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
                                    dragAsMagnify(index:index)
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
                    dragGesture(index:index)
                        .simultaneously(with: magnificationGesture(index:index))
                        .simultaneously(with: rotationGesture(index:index))
                        .simultaneously(with: TapGesture().onEnded{sticker.isSelected.toggle()})
                )

        }
    }
    
func MetricStickerViewRender(sticker: Sticker,index: Int, workout: WorkoutModel)-> some View{
    let scaledSize = 150 * sticker.scale
    let relativeHeight = -((scaledSize/2) * 1.732)
    return ZStack{
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
                    .offset(x: scaledSize / 2, y: relativeHeight)
                    .gesture(
                        dragAsMagnify(index:index)
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
                    .offset(x: -scaledSize / 2, y: relativeHeight)

            }
        }
    }
    .frame(width: scaledSize, height: scaledSize)
    .rotationEffect(sticker.rotation)
    .position(sticker.position)
    .gesture(
        dragGesture(index:index)
            .simultaneously(with: magnificationGesture(index:index))
            .simultaneously(with: rotationGesture(index:index))
            .simultaneously(with: TapGesture().onEnded{sticker.isSelected.toggle()})
        )
    }
    
    func magnificationGesture(index:Int) -> some Gesture{
        MagnifyGesture()
            .onChanged{value in
                selectedStickers[index].scale = selectedStickers[index].lastScale * value.magnification
            }
            .onEnded{_ in
                selectedStickers[index].lastScale = selectedStickers[index].scale
            }
    }
    func rotationGesture(index:Int) -> some Gesture{
        RotationGesture()
            .onChanged{value in
                selectedStickers[index].rotation = selectedStickers[index].lastRotation + value
            }
            .onEnded{_ in
                selectedStickers[index].lastRotation = selectedStickers[index].rotation
            }
    }
    func dragGesture(index:Int) -> some Gesture{
        DragGesture()
            .onChanged{value in
                selectedStickers[index].position = value.location
            }
    }
    
    func dragAsMagnify(index:Int) -> some Gesture{
        DragGesture()
            .onChanged{ value in
                let delta = -value.translation.height / (75/2)
                let newScale = max(0.5, selectedStickers[index].lastScale + delta)
                selectedStickers[index].scale = newScale
//                let width = Double(value.location.x)
//                if -50.0<width && width<70.0{
//                    selectedStickers[index].scale = selectedStickers[index].lastScale + width/100
//                }
            }
            .onEnded{ _ in
                selectedStickers[index].lastScale = selectedStickers[index].scale
            }
    }
    
}

func placeholder(icon: String) -> some View {
    Rectangle()
        .foregroundColor(.gray.opacity(0.2))
        .overlay {
            Image(systemName: icon)
                .foregroundStyle(.white)
                .font(.system(size: 50))
        }
}





#Preview {
    SingleRunView(workout: WorkoutModel(id: UUID(), date: Date(), duration: 2246, distance: 1020))
}

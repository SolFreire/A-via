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

    
    var Stickers = ["StickerCoco", "StickerIracema" ,"StickerUnifor" ,"StickerIguatemi"]
    
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
                imageSection()
                
                if viewModel.type == .edit {
                    editSection
                } else {
                    infoSection
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
                        Image(uiImage:image)
                            .resizable()
                            .scaledToFill()
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
        VStack(alignment: .leading, spacing: 12){
                   Text(dateFormatter.string(from: workout.date))
                       .font(.title)
                       .fontWeight(.semibold)
                       .padding(.horizontal)
       
                   HStack(spacing:36){
       
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
                   .padding(.horizontal)
                   VStack(alignment: .leading, spacing: 8){
                       Text("Pace")
                           .font(.body)
                           .fontWeight(.medium)
                       Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                           .font(.title3)
                           .fontWeight(.medium)
                   }.padding(.horizontal)
               }
               .frame(width:318, height: 187, alignment: .leading)
               .background(.gray.opacity(0.1))
        
    }
    
    var editSection: some View {
        
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
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        
        ToolbarItem(placement: .cancellationAction) {
            if viewModel.type == .edit {
                Button("Cancel", systemImage: "xmark") {
                    viewModel.cancelEditing(workout: workout)
                    pickerItem = nil
                }
            }
        }
        
        ToolbarItem(placement: .confirmationAction){
            if viewModel.type == .edit{
                Button("Done", systemImage: "checkmark"){
                    viewModel.confirmEdit(workout:workout, context: context, ImageView: imageSection())
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
            
        }
        ToolbarSpacer(.fixed, placement:.topBarTrailing)
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
    
    func StickerView(for index: Int) -> some View{
        let sticker = selectedStickers[index]
        return Image(sticker.name)
            .resizable()
            .scaledToFit()
            .frame(width: 75,height: 75)
            .scaleEffect(sticker.scale)
            .rotationEffect(sticker.rotation)
            .position(sticker.position)
            .gesture(
                dragGesture(index:index)
                .simultaneously(with: magnificationGesture(index:index))
                .simultaneously(with: rotationGesture(index:index))
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

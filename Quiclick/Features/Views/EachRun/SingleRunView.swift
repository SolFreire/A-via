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

    
    var Stickers: [String: [String]] = [
        "Métricas": ["Metrics"],
        "Locais": ["StickerCoco", "StickerIracema" ,"StickerUnifor" ,"StickerIguatemi"],
        "Acessórios": ["StickerTenis", "StickerOculos", "StickerGarrafa", "StickerRelogio"]
    ]

    
    let workout: WorkoutModel
    var showsBackButton: Bool {
        if viewModel.type == .edit {
            return true
        } else {
            return false
        }
    }
    
    //Provisório:
    @State private var tabs: [String] = ["Métricas", "Locais", "Acessórios"]
    @State private var activeTab: String = "Métricas"
    @State private var contentStickers: [String] = ["Metrics"]
    //---------------------------
    
    
    var body : some View{

        VStack {
            
            Group {
                
                if viewModel.type == .edit {
                    
                    
                    imageSection()
                    Spacer()
                    editSection
                    
                    
                } else {
                    ScrollView(.vertical, showsIndicators: false){
                        
                        imageSection()
                        Spacer()
                        infoSection
                        
                    }
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
        .ignoresSafeArea(edges: .bottom)    }

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
                                    StickersView(for: index)
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
                                StickersView(for: index)
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
            Text("Informações da Corrida")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.limeButtons)
                .padding()
            Text(dateFormatter.string(from: workout.date))
               .font(.title3)
               .fontWeight(.bold)
               .padding()
            VStack(alignment: .leading){
                    VStack(alignment: .leading, spacing: 12){
                        HStack(spacing: 50){
                            Text("Distância")
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Text("\((workout.distance/1000).formatted()) km")
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                        HStack(spacing: 70){
                            Text("Tempo")
                                .font(.body)
                                .fontWeight(.medium)
                            Text(formatDuration(workout.duration))
                                .font(.title3)
                                .fontWeight(.medium)
                        }

                        HStack(spacing: 80){
                            Text("Pace")
                                .font(.body)
                                .fontWeight(.medium)
                            Text("\(workout.pace.formatted(.number.precision(.fractionLength(2))))/km")
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                        
                    }
                    .padding(16)


            }
               }
               .frame(minWidth:318, alignment: .leading)
               .background(.carbonCards)
               .cornerRadius(12)

    }
    
    var editSectionContent: some View {
        HStack (alignment: .center, spacing: 5){
            ForEach(tabs, id: \.self) {tab in
                Button (action: {
                    withAnimation(.snappy) {
                        activeTab = tab
                        for key in Stickers.keys {
                            if tab == key {
                                contentStickers = Stickers[key]!
                            }
                        }
                    }
                }) {
                    Text(tab)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(
                            activeTab == tab ?
                            Color(.limeButtons) :
                                Color.white)
                        .padding(2)
                        .background(
                            activeTab == tab ?
                                Color(.limeButtons).opacity(0.2) :
                                Color(.carbonCards)
                        )
                        .cornerRadius(6)
                        .fontWeight(.semibold)
                }
                .buttonStyle(.plain)
            }
        }
    }

    var editSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Stickers")
                .font(.headline)
                .padding(.horizontal,26)
                .foregroundStyle(.limeButtons)
        
            VStack(alignment: .center){
                
                ViewThatFits {
                    editSectionContent
                        .padding(.bottom, 20)
                    ScrollView(.horizontal) {
                        editSectionContent
                            .padding(.bottom, 20)
                    }
                }
                
                
                ScrollView(.horizontal) {

                    LazyHGrid(rows: Array(repeating: .init(.flexible(minimum: 75, maximum: 75), spacing: 6.0), count: 1), spacing: 6.0){
                        ForEach(contentStickers, id:\.self){ sticker in
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 80,height: 80)
                                .overlay{
                                    Image(sticker)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(5)
                                }
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    selectedStickers.append(Sticker(name:sticker))
                                }
                        }
                        .foregroundColor(.black.opacity(0.3))
                    }

                }
                .padding(.bottom, 20)
                
            }
            .padding(14)
            .background(.carbonCards)
            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16, topTrailingRadius: 16))
        }
        .padding(16)
        .background(.carbonCards)
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16, topTrailingRadius: 16))
    }

    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {

        ToolbarItem(placement: .cancellationAction) {
            if viewModel.type == .edit {
                Button("Cancel", systemImage: "xmark") {
                    pickerItem = nil
                    pickerImage = nil
                    viewModel.cancelEditing(workout: workout)
                    pickerItem = nil
                    pickerImage = nil
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
    func StickersView(for index: Int) -> some View {
        let sticker = selectedStickers[index]
        StickerView(selectedStickers: $selectedStickers, index: index, sticker: sticker, workout: workout)
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

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
        case regular, edit, noImage, resize
    }

    @State private var viewModel = SingleRunViewModel()
    @Environment(\.modelContext) private var context
    @State var showImageSheet = false

    let workout: WorkoutModel
    var showsBackButton: Bool {
        if viewModel.type == .edit {
            return true
        } else {
            return false
        }
    }


    var body : some View{

        VStack {
            
            Group {
                switch viewModel.type {
                case .edit:
                    imageSection()
                    Spacer()
                    editSection
                case .resize:
                    imageSection()
                    Spacer()
                    resizeSection
                default:
                    ScrollView(.vertical, showsIndicators: false) {
                        imageSection(); Spacer(); infoSection
                    }
                }
            }
            
                
        }
        .toolbar {
            toolbarContent
        }
        .onChange(of: viewModel.pickerItem){
            Task { await viewModel.loadPickedImage() }
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
                PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                    placeholder(icon: "photo.badge.plus")
                }
                
            case .resize:
                if let image = viewModel.pickerImage {
                    CroppableImage(
                        image: image,
                        cropSize: viewModel.cropFormat.previewSize,
                        scale: $viewModel.cropScale,
                        offset: $viewModel.cropOffset
                    )
                    .overlay{
                        CropGuideView(format : viewModel.cropFormat)
                    }
                }
            case .edit:
                // A imagem já salva tem precedência sobre a recém-escolhida;
                // antes isso eram dois blocos idênticos em um if/else.
                if let image = workout.image ?? viewModel.pickerImage {
                    ZStack{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()

                        ForEach(viewModel.selectedStickers.indices, id:\.self){ index in
                            StickersView(for: index)
                        }
                    }
                    .onTapGesture{ viewModel.deselectAllStickers() }
                }

            case .regular:
                if let image = workout.image {
                          Image(uiImage: image)
                              .resizable()
                              .scaledToFill()
                       }
                
            }
            
        }
        .frame(width: previewSize.width, height: previewSize.height)
        .clipped()
    }

    /// Área do preview. Fora do estado sem imagem ela segue a proporção do
    /// formato escolhido, para que o recorte não seja cortado de novo aqui
    /// nem na renderização final.
    private var previewSize: CGSize {
        viewModel.type == .noImage
        ? CGSize(width: CropFormat.previewMaxWidth, height: CropFormat.previewMaxHeight)
        : viewModel.cropFormat.previewSize
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
                            
                            Text("\((workout.distance/1000).formatted(.number.precision(.fractionLength(2)))) km")
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
                            Text("\(paceformatter(workout.pace))/km")
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
    
    var resizeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Redimensionamento")
                .font(.headline)
                .padding(.horizontal, 26)
                .padding(.bottom, 12)
                .foregroundStyle(.limeButtons)
            Spacer()
            HStack(spacing: 12) {
                ForEach(CropFormat.allCases) { format in
                    Button {
                        withAnimation(.snappy) { viewModel.selectFormat(format) }
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: format.icon)
                                .rotationEffect(format.iconRotation)
                            Text(format.label).font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(viewModel.cropFormat == format
                                    ? Color(.limeButtons).opacity(0.2)
                                    : Color(.carbonCards))
                        .foregroundStyle(viewModel.cropFormat == format
                                         ? Color(.limeButtons) : .white)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .padding(16)
        .frame( minHeight: 200, maxHeight: 250, alignment: .top)
        .background(.carbonCards)
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16, topTrailingRadius: 16))
    }

    var editSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Stickers")
                .font(.headline)
                .padding(.horizontal,26)
                .foregroundStyle(.limeButtons)
        
            VStack(alignment: .center){
                
                HStack (spacing: 5) {
                    ForEach(StickerCategory.allCases) { category in
                        Button (action: {
                            withAnimation(.snappy) {
                                viewModel.activeCategory = category
                            }
                        }) {
                            Text(category.title)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(
                                    viewModel.activeCategory == category ?
                                    Color(.limeButtons) :
                                        Color.white)
                                .padding(2)
                                .background(
                                    viewModel.activeCategory == category ?
                                        Color(.limeButtons).opacity(0.2) :
                                        Color(.carbonCards)
                                )
                                .cornerRadius(6)
                                .fontWeight(.semibold)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.bottom, 20)
                
                
                ScrollView(.horizontal) {

                    LazyHGrid(rows: Array(repeating: .init(.flexible(minimum: 75, maximum: 75), spacing: 6.0), count: 1), spacing: 6.0){
                        ForEach(viewModel.activeCategory.stickerNames, id:\.self){ sticker in
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
                                    viewModel.addSticker(named: sticker)
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
                    viewModel.cancelEditing(workout: workout)
                }
            }
            if viewModel.type == .resize {
                Button("Cancel", systemImage: "xmark") {
                    viewModel.cancelResize()
                }
            }
        }

        ToolbarItem(placement: .confirmationAction){
            if viewModel.type == .edit{
                Button("Done", systemImage: "checkmark"){
                    // Tira as alças de seleção antes de renderizar, senão elas
                    // entram na imagem final.
                    viewModel.deselectAllStickers()
                    // A View renderiza — é ela que conhece SwiftUI — e entrega
                    // os bytes para a ViewModel salvar. A escala vem do formato
                    // escolhido, preservando o redimensionamento.
                    let rendered = ImageExporter.png(from: imageSection(),
                                                     scale: viewModel.cropFormat.exportScale)
                    viewModel.confirmEdit(workout: workout, context: context, imageData: rendered)
                }
            }
            if viewModel.type == .resize{
                Button("Done", systemImage: "checkmark"){
                    viewModel.confirmResize()
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
        let sticker = viewModel.selectedStickers[index]
        StickerView(selectedStickers: $viewModel.selectedStickers, index: index, sticker: sticker, workout: workout)
    }
   
}

#Preview {
    SingleRunView(workout: WorkoutModel(id: UUID(), date: Date(), duration: 2246, distance: 1020))
}

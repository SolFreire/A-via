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
    @Namespace private var topID

    @State private var viewModel = WeeklyTemplateViewModel()
    @State private var shareTemplate: TypeTemplateView = .distanceregular
    @State private var toShareTemplateSheet: ToShareTemplate? = nil

    private let listTemplateDistance: [TypeTemplateView] = [.distance5km, .distance10km, .distance15km, .distance21km, .distance42km]
    private let listTemplateTime: [TypeTemplateView] = [.timeregular, .time2hours]
    private let templatePace: TypeTemplateView = .bestpace

    private var bestDistance: Double {
        viewModel.bestDistance(in: workouts)
    }

    private var bestTime: TimeInterval {
        viewModel.bestTime(in: workouts)
    }

    private var bestPace: Double {
        viewModel.bestPace(in: workouts)
    }

    var body: some View {
        ScrollViewReader { proxy in
            NavigationStack {
                if workouts.isEmpty {
                    EmptyWeekView()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        featuredCarousel
                            .id(topID)

                        VStack(alignment: .leading, spacing: 40) {
                            templateSection(
                                title: "Templates de distância",
                                templates: listTemplateDistance,
                                proxy: proxy
                            ) { viewModel.isDistanceTemplateUnlocked($0, bestDistance: bestDistance) }

                            templateSection(
                                title: "Templates de tempo",
                                templates: listTemplateTime,
                                proxy: proxy
                            ) { viewModel.isTimeTemplateUnlocked($0, bestTimeInHours: bestTime / 3600) }

                            VStack(alignment: .leading, spacing: 10) {
                                sectionHeader("Templates de pace")
                                TemplateThumbnail(template: templatePace, isUnlocked: true) {
                                    select(templatePace, proxy: proxy)
                                }
                            }
                        }
                        .padding()
                        .navigationTitle("Templates")
                    }
                }
            }
        }
    }

    // MARK: - Sections

    /// Horizontal carousel of large share previews for the currently selected template.
    private var featuredCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(ShareMode.allCases, id: \.self) { mode in
                    let toShareTemplate = ToShareTemplate(
                        template: shareTemplate,
                        shareMode: mode,
                        bestPace: bestPace,
                        bestTime: bestTime
                    )

                    ImageTemplateView(toShareTemplate: toShareTemplate)
                        .onTapGesture {
                            toShareTemplateSheet = toShareTemplate
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding()
        .sheet(item: $toShareTemplateSheet) { shareTemplate in
            TemplateShareView(toShareTamplate: shareTemplate)
        }
    }

    /// A titled row of lockable template thumbnails.
    private func templateSection(
        title: String,
        templates: [TypeTemplateView],
        proxy: ScrollViewProxy,
        isUnlocked: @escaping (TypeTemplateView) -> Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader(title)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(templates, id: \.self) { template in
                        TemplateThumbnail(template: template, isUnlocked: isUnlocked(template)) {
                            select(template, proxy: proxy)
                        }
                    }
                }
            }
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(.medium)
    }


    private func select(_ template: TypeTemplateView, proxy: ScrollViewProxy) {
        shareTemplate = template
        withAnimation {
            proxy.scrollTo(topID, anchor: .top)
        }
    }
}


struct TemplateThumbnail: View {
    let template: TypeTemplateView
    let isUnlocked: Bool
    let onTap: () -> Void

   
    private static let size = CGSize(width: 76, height: 135)

    var body: some View {
        Image(template.image)
            .resizable()
            .scaledToFill()
            .frame(width: Self.size.width, height: Self.size.height)
            .clipped()
            .overlay {
                if !isUnlocked {
                    ZStack {
                        Color.gray.opacity(0.7)
                        Image(systemName: "lock.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .contentShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture {
                if isUnlocked { onTap() }
            }
            .accessibilityAddTraits(isUnlocked ? .isButton : [])
    }
}

#Preview {
    WeeklyTemplateView()
}

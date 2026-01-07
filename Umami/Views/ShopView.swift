//
//  ShopView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct ShopView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var showingFilters = false
    @State private var showingSortOptions = false
    @State private var selectedFilters = FilterOptions()
    @State private var sakes: [Sake] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                header

                // Sort and Filter buttons
                sortFilterBar

                // Sake list
                ScrollView {
                    if isLoading {
                        ProgressView("Loading sake...")
                            .padding()
                    } else if let error = errorMessage {
                        VStack(spacing: 16) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.system(size: 40))
                                .foregroundColor(.orange)
                            Text("Error Loading Data")
                                .font(.headline)
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Button("Retry") {
                                Task { await loadSakes() }
                            }
                        }
                        .padding()
                    } else {
                        LazyVStack(spacing: AppTheme.Spacing.md) {
                            ForEach(Array(sakes.enumerated()), id: \.element.id) { index, sake in
                                SakeListCard(
                                    sake: sake,
                                    showDiscount: index % 2 == 0,
                                    discountPercentage: [13, 10, 9][index % 3]
                                )
                                .padding(.horizontal, AppTheme.Spacing.md)
                            }
                        }
                        .padding(.vertical, AppTheme.Spacing.md)

                        Spacer(minLength: 80)
                    }
                }
                .background(AppTheme.Colors.lightBackground)
                .task {
                    await loadSakes()
                }
                .refreshable {
                    await loadSakes()
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingFilters) {
            FilterView(filters: $selectedFilters)
        }
        .sheet(isPresented: $showingSortOptions) {
            SortOptionsView()
        }
    }

    // MARK: - Header
    private var header: some View {
        HStack {
            Text(LocalizedStrings.get("shop", language: languageManager.currentLanguage))
                .font(AppTheme.Typography.title)
                .fontWeight(.bold)

            Text("22,341")
                .font(AppTheme.Typography.title3)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Spacer()

            LanguageToggle()

            Button(action: {}) {
                Image(systemName: "cart")
                    .font(.title3)
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }

            Button(action: {}) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(AppTheme.Colors.textPrimary)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.md)
        .padding(.vertical, AppTheme.Spacing.md)
        .background(Color.white)
    }

    // MARK: - Load Sakes
    private func loadSakes() async {
        isLoading = true
        errorMessage = nil

        do {
            print("📡 Fetching sakes for shop...")
            let response = try await APIService.shared.fetchAllSake(
                sortBy: "rating",
                sortOrder: "desc",
                limit: 100
            )

            print("✅ Received \(response.data.count) sakes")
            sakes = response.data.map { $0.toSake() }
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error loading sakes: \(error)")
        }

        isLoading = false
    }

    // MARK: - Sort Filter Bar
    private var sortFilterBar: some View {
        HStack(spacing: AppTheme.Spacing.lg) {
            Button(action: { showingSortOptions = true }) {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.subheadline)
                    Text("Sort")
                        .font(AppTheme.Typography.callout)
                }
                .foregroundColor(AppTheme.Colors.textPrimary)
            }

            Divider()
                .frame(height: 20)

            Button(action: { showingFilters = true }) {
                HStack(spacing: 6) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.subheadline)
                    Text("Filter")
                        .font(AppTheme.Typography.callout)
                }
                .foregroundColor(AppTheme.Colors.textPrimary)
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Spacing.md)
        .padding(.vertical, AppTheme.Spacing.md)
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(AppTheme.Colors.cardBackground)
                .frame(height: 1),
            alignment: .bottom
        )
    }
}

// MARK: - Filter Options Model
struct FilterOptions {
    var selectedTypes: Set<SakeClassification> = []
    var minRating: Double = 0
    var priceRange: ClosedRange<Double> = 0...1000
    var onlyOffers: Bool = false
    var selectedPrefectures: Set<String> = []
    var selectedRiceVarieties: Set<String> = []
}

// MARK: - Filter View
struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var filters: FilterOptions
    @State private var localFilters: FilterOptions

    init(filters: Binding<FilterOptions>) {
        _filters = filters
        _localFilters = State(initialValue: filters.wrappedValue)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
                    // Type filter
                    typeFilterSection

                    Divider()

                    // Rating filter
                    ratingFilterSection

                    Divider()

                    // Price filter
                    priceFilterSection

                    Divider()

                    // Prefecture filter
                    prefectureFilterSection

                    Divider()

                    // Rice variety filter
                    riceVarietyFilterSection

                    Spacer(minLength: 100)
                }
                .padding(AppTheme.Spacing.md)
            }
            .navigationTitle("Shop")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        localFilters = FilterOptions()
                    }
                    .foregroundColor(AppTheme.Colors.primary)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(AppTheme.Colors.textPrimary)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    filters = localFilters
                    dismiss()
                }) {
                    Text("Show 22,340 sake")
                        .font(AppTheme.Typography.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.Colors.primary)
                        .cornerRadius(AppTheme.CornerRadius.md)
                }
                .padding(AppTheme.Spacing.md)
                .background(Color.white)
            }
        }
    }

    // MARK: - Type Filter Section
    private var typeFilterSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Type")
                .font(AppTheme.Typography.title3)
                .fontWeight(.semibold)

            let types: [SakeClassification] = [.junmai, .junmaiGinjo, .junmaiDaiginjo, .ginjo, .daiginjo, .honjozo, .sparkling]

            FlowLayout(spacing: AppTheme.Spacing.sm) {
                ForEach(types, id: \.self) { type in
                    FilterChip(
                        title: type.rawValue,
                        isSelected: localFilters.selectedTypes.contains(type),
                        action: {
                            if localFilters.selectedTypes.contains(type) {
                                localFilters.selectedTypes.remove(type)
                            } else {
                                localFilters.selectedTypes.insert(type)
                            }
                        }
                    )
                }
            }
        }
    }

    // MARK: - Rating Filter Section
    private var ratingFilterSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Text("Rating")
                    .font(AppTheme.Typography.title3)
                    .fontWeight(.semibold)

                Spacer()

                Text("\(String(format: "%.1f", localFilters.minRating))+")
                    .font(AppTheme.Typography.callout)
                    .foregroundColor(AppTheme.Colors.starColor)
            }

            HStack(spacing: 4) {
                ForEach(0..<5) { index in
                    Image(systemName: index < Int(localFilters.minRating) ? "star.fill" : "star")
                        .foregroundColor(AppTheme.Colors.starColor)
                        .onTapGesture {
                            localFilters.minRating = Double(index + 1)
                        }
                }
            }

            Slider(value: $localFilters.minRating, in: 0...5, step: 0.5)
                .tint(AppTheme.Colors.starColor)
        }
    }

    // MARK: - Price Filter Section
    private var priceFilterSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Text("Price")
                    .font(AppTheme.Typography.title3)
                    .fontWeight(.semibold)

                Spacer()

                Text("$\(Int(localFilters.priceRange.lowerBound)) - $\(Int(localFilters.priceRange.upperBound))")
                    .font(AppTheme.Typography.callout)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            // Price range slider would go here (simplified for now)
            HStack {
                Text("$0")
                    .font(AppTheme.Typography.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)

                Spacer()

                Text("$1000+")
                    .font(AppTheme.Typography.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            Toggle("Only shows offers", isOn: $localFilters.onlyOffers)
                .font(AppTheme.Typography.callout)
                .tint(AppTheme.Colors.primary)
        }
    }

    // MARK: - Prefecture Filter Section
    private var prefectureFilterSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Prefecture")
                .font(AppTheme.Typography.title3)
                .fontWeight(.semibold)

            let prefectures = [
                ("🇯🇵", "Yamaguchi", 3521),
                ("🇯🇵", "Niigata", 6589),
                ("🇯🇵", "Fukui", 1839),
                ("🇯🇵", "Yamagata", 1244),
                ("🇯🇵", "Kyoto", 1114)
            ]

            FlowLayout(spacing: AppTheme.Spacing.sm) {
                ForEach(prefectures, id: \.1) { flag, name, count in
                    FilterChip(
                        title: "\(flag) \(name) (\(count))",
                        isSelected: localFilters.selectedPrefectures.contains(name),
                        action: {
                            if localFilters.selectedPrefectures.contains(name) {
                                localFilters.selectedPrefectures.remove(name)
                            } else {
                                localFilters.selectedPrefectures.insert(name)
                            }
                        }
                    )
                }
            }

            Button("Show all") {
                // Show all prefectures
            }
            .font(AppTheme.Typography.callout)
            .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }

    // MARK: - Rice Variety Filter Section
    private var riceVarietyFilterSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Rice Variety")
                .font(AppTheme.Typography.title3)
                .fontWeight(.semibold)

            let riceVarieties = [
                ("Yamada Nishiki", 1844),
                ("Gohyakumangoku", 1043),
                ("Omachi", 830),
                ("Miyama Nishiki", 817)
            ]

            FlowLayout(spacing: AppTheme.Spacing.sm) {
                ForEach(riceVarieties, id: \.0) { name, count in
                    FilterChip(
                        title: "\(name) (\(count))",
                        isSelected: localFilters.selectedRiceVarieties.contains(name),
                        action: {
                            if localFilters.selectedRiceVarieties.contains(name) {
                                localFilters.selectedRiceVarieties.remove(name)
                            } else {
                                localFilters.selectedRiceVarieties.insert(name)
                            }
                        }
                    )
                }
            }
        }
    }
}

// MARK: - Filter Chip
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTheme.Typography.subheadline)
                .padding(.horizontal, AppTheme.Spacing.md)
                .padding(.vertical, AppTheme.Spacing.sm)
                .background(isSelected ? AppTheme.Colors.primary.opacity(0.1) : AppTheme.Colors.cardBackground)
                .foregroundColor(isSelected ? AppTheme.Colors.primary : AppTheme.Colors.textPrimary)
                .cornerRadius(AppTheme.CornerRadius.lg)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.lg)
                        .stroke(isSelected ? AppTheme.Colors.primary : Color.clear, lineWidth: 1)
                )
        }
    }
}

// MARK: - Flow Layout (Custom Layout for Chips)
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX,
                                     y: bounds.minY + result.frames[index].minY),
                         proposal: ProposedViewSize(result.frames[index].size))
        }
    }

    struct FlowResult {
        var frames: [CGRect] = []
        var size: CGSize = .zero

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }

                frames.append(CGRect(origin: CGPoint(x: currentX, y: currentY), size: size))
                currentX += size.width + spacing
                lineHeight = max(lineHeight, size.height)
            }

            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

// MARK: - Sort Options View
struct SortOptionsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedOption = 0

    let options = [
        "Highest rated",
        "Most reviewed",
        "Price: Low to High",
        "Price: High to Low",
        "Alphabetical",
        "Newest additions",
        "Trending"
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(options.indices, id: \.self) { index in
                    Button(action: {
                        selectedOption = index
                        dismiss()
                    }) {
                        HStack {
                            Text(options[index])
                                .foregroundColor(AppTheme.Colors.textPrimary)

                            Spacer()

                            if selectedOption == index {
                                Image(systemName: "checkmark")
                                    .foregroundColor(AppTheme.Colors.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Sort by")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(AppTheme.Colors.primary)
                }
            }
        }
    }
}

#Preview {
    ShopView()
        .environmentObject(LanguageManager())
}

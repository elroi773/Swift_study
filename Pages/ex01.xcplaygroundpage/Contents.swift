import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var focusMode: FocusMode = .work

    // Fitness-style ring progress (0.0 ~ 1.0)
    @State private var moveProgress: Double = 0.78
    @State private var exerciseProgress: Double = 0.52
    @State private var standProgress: Double = 0.90

    @State private var notificationsOn = true
    @State private var autoSyncOn = true

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    // Header Card (Apple-ish)
                    headerCard

                    // Focus Mode Segment
                    focusModeCard

                    // Fitness Rings (감성 폭발)
                    ringsCard

                    // Quick Settings (List 느낌)
                    settingsCard

                    // Footer spacing
                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(.systemBackground),
                        Color(.secondarySystemBackground),
                        Color(.systemBackground)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // action
                    } label: {
                        Image(systemName: "bell.badge")
                    }
                }
            }
        }
    }

    // MARK: - Components

    private var headerCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 56, height: 56)
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 34))
                    .symbolRenderingMode(.hierarchical)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("오늘의 리듬, Kim ✨")
                    .font(.headline)
                Text("링 + 글래스 카드로 감성 폭발")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                // action
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(10)
                    .background(.thinMaterial, in: Circle())
            }
        }
        .padding(16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(.white.opacity(0.15), lineWidth: 1)
        )
    }

    private var focusModeCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Focus Mode", systemImage: "moon.stars.fill")
                .font(.headline)
                .symbolRenderingMode(.hierarchical)

            Picker("Focus", selection: $focusMode) {
                ForEach(FocusMode.allCases) { mode in
                    Text(mode.title).tag(mode)
                }
            }
            .pickerStyle(.segmented)

            HStack {
                Image(systemName: focusMode.icon)
                    .symbolRenderingMode(.hierarchical)
                    .font(.title2)

                VStack(alignment: .leading, spacing: 2) {
                    Text(focusMode.subtitle)
                        .font(.subheadline)
                    Text(focusMode.detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .padding(12)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .padding(16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(.white.opacity(0.12), lineWidth: 1)
        )
    }

    private var ringsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Activity", systemImage: "figure.run")
                    .font(.headline)
                    .symbolRenderingMode(.hierarchical)

                Spacer()

                Text("\(Int(moveProgress * 100))%")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }

            HStack(alignment: .center, spacing: 16) {
                ActivityRingsView(
                    move: moveProgress,
                    exercise: exerciseProgress,
                    stand: standProgress
                )
                .frame(width: 140, height: 140)

                VStack(alignment: .leading, spacing: 10) {
                    ringLegendRow(title: "Move", value: "\(Int(moveProgress * 520)) kcal", systemImage: "flame.fill", color: Color(.systemPink))
                    ringLegendRow(title: "Exercise", value: "\(Int(exerciseProgress * 60)) min", systemImage: "figure.run", color: Color(.systemGreen))
                    ringLegendRow(title: "Stand", value: "\(Int(standProgress * 12)) hr", systemImage: "figure.stand", color: Color(.systemCyan))
                }

                Spacer(minLength: 0)
            }
            .padding(.vertical, 4)

            VStack(alignment: .leading, spacing: 8) {
                Text("Tune the vibe")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Slider(value: $moveProgress, in: 0...1, step: 0.01) {
                    Text("Move")
                }
                .tint(Color(.systemPink))
            }

            HStack(spacing: 10) {
                metricPill(title: "Streak", value: "6d", systemImage: "flame.fill")
                metricPill(title: "Sessions", value: "3", systemImage: "timer")
                metricPill(title: "Mood", value: "Good", systemImage: "face.smiling.fill")
            }
        }
        .padding(16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(.white.opacity(0.12), lineWidth: 1)
        )
    }

    private func ringLegendRow(title: String, value: String, systemImage: String, color: Color) -> some View {
        HStack(spacing: 10) {
            Image(systemName: systemImage)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(color)
                .frame(width: 18)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.subheadline.weight(.semibold))
                    .monospacedDigit()
            }
        }
    }

    private func metricPill(title: String, value: String, systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: systemImage)
                    .symbolRenderingMode(.hierarchical)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(value)
                .font(.title3.weight(.semibold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var settingsCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Quick Settings", systemImage: "switch.2")
                .font(.headline)
                .symbolRenderingMode(.hierarchical)

            VStack(spacing: 0) {
                Toggle(isOn: $notificationsOn) {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .padding(.vertical, 10)

                Divider().opacity(0.6)

                Toggle(isOn: $autoSyncOn) {
                    Label("Auto Sync", systemImage: "arrow.triangle.2.circlepath")
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .padding(.vertical, 10)

                Divider().opacity(0.6)

                NavigationLink {
                    DetailView()
                } label: {
                    HStack {
                        Label("More", systemImage: "gearshape.fill")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .padding(16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(.white.opacity(0.12), lineWidth: 1)
        )
    }
}

// MARK: - Fitness Rings Views

struct ActivityRingsView: View {
    var move: Double
    var exercise: Double
    var stand: Double

    var body: some View {
        ZStack {
            Ring(progress: stand, lineWidth: 16, color: Color(.systemCyan))
            Ring(progress: exercise, lineWidth: 16, color: Color(.systemGreen))
                .padding(18)
            Ring(progress: move, lineWidth: 16, color: Color(.systemPink))
                .padding(36)

            VStack(spacing: 2) {
                Text("MOVE")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text("\(Int(move * 520))")
                    .font(.title3.weight(.semibold))
                    .monospacedDigit()
            }
        }
        .animation(.spring(response: 0.55, dampingFraction: 0.85), value: move)
        .animation(.spring(response: 0.55, dampingFraction: 0.85), value: exercise)
        .animation(.spring(response: 0.55, dampingFraction: 0.85), value: stand)
    }
}

struct Ring: View {
    var progress: Double
    var lineWidth: CGFloat
    var color: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.18), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))

            Circle()
                .trim(from: 0, to: max(0, min(1, progress)))
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .shadow(color: color.opacity(0.35), radius: 6, x: 0, y: 2)
        }
        .accessibilityLabel("Progress")
        .accessibilityValue("\(Int(progress * 100)) percent")
    }
}

// MARK: - Supporting Types

enum FocusMode: String, CaseIterable, Identifiable {
    case work, personal, sleep
    var id: String { rawValue }

    var title: String {
        switch self {
        case .work: return "Work"
        case .personal: return "Personal"
        case .sleep: return "Sleep"
        }
    }

    var icon: String {
        switch self {
        case .work: return "briefcase.fill"
        case .personal: return "heart.fill"
        case .sleep: return "bed.double.fill"
        }
    }

    var subtitle: String {
        switch self {
        case .work: return "집중 모드: 업무"
        case .personal: return "집중 모드: 개인"
        case .sleep: return "집중 모드: 수면"
        }
    }

    var detail: String {
        switch self {
        case .work: return "알림을 줄이고 중요한 작업에 집중해요."
        case .personal: return "가벼운 흐름으로, 필요한 것만."
        case .sleep: return "편안하게, 방해 없이 쉬어요."
        }
    }
}

struct DetailView: View {
    var body: some View {
        List {
            Section("About") {
                Label("SwiftUI Sample", systemImage: "swift")
                Label("iOS-like UI", systemImage: "iphone")
            }
            Section("Tips") {
                Text("Material(.thin/.regular) + SF Symbols + RoundedRectangle 조합이 애플 감성의 핵심!")
            }
        }
        .navigationTitle("More")
    }
}

// MARK: - Playground Live View
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(ContentView())

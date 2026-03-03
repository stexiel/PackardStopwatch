import SwiftUI
import ActivityKit

struct ContentView: View {
    @StateObject private var stopwatch = StopwatchManager()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: stopwatch.isRunning ? 
                    [Color(red: 0.1, green: 0.23, blue: 0.1), Color(red: 0.18, green: 0.3, blue: 0.18)] :
                    [Color(red: 0.23, green: 0.1, blue: 0.1), Color(red: 0.3, green: 0.18, blue: 0.18)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text(stopwatch.formattedTime)
                    .font(.system(size: 72, weight: .ultraLight, design: .monospaced))
                    .foregroundColor(stopwatch.isRunning ? .green : .red)
                    .shadow(color: .white.opacity(0.3), radius: 20)
                    .onTapGesture {
                        stopwatch.toggle()
                    }
                    .onLongPressGesture(minimumDuration: 0.5) {
                        stopwatch.reset()
                    }
                
                Spacer()
                
                Text("Tap - Start/Pause • Hold - Reset")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 50)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        if #available(iOS 16.1, *) {
                            stopwatch.toggleLiveActivity()
                        }
                    }) {
                        HStack {
                            Image(systemName: stopwatch.liveActivityActive ? "checkmark.circle.fill" : "pin.circle")
                            Text(stopwatch.liveActivityActive ? "Live Activity" : "Enable Live Activity")
                                .font(.caption)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(stopwatch.liveActivityActive ? Color.green.opacity(0.3) : Color.white.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(stopwatch.liveActivityActive ? Color.green : Color.white.opacity(0.3), lineWidth: 2)
                                )
                        )
                        .foregroundColor(.white)
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}

class StopwatchManager: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning = false
    @Published var liveActivityActive = false
    
    private var timer: Timer?
    private var startTime: Date?
    private var currentActivity: Activity<StopwatchAttributes>?
    
    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        let milliseconds = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    func toggle() {
        if isRunning {
            pause()
        } else {
            start()
        }
    }
    
    func start() {
        isRunning = true
        startTime = Date().addingTimeInterval(-elapsedTime)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self, let startTime = self.startTime else { return }
            self.elapsedTime = Date().timeIntervalSince(startTime)
            
            if self.liveActivityActive {
                if #available(iOS 16.1, *) {
                    self.updateLiveActivity()
                }
            }
        }
        
        if liveActivityActive {
            if #available(iOS 16.1, *) {
                updateLiveActivity()
            }
        }
    }
    
    func pause() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        
        if liveActivityActive {
            if #available(iOS 16.1, *) {
                updateLiveActivity()
            }
        }
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
        isRunning = false
        startTime = nil
        
        if liveActivityActive {
            if #available(iOS 16.1, *) {
                updateLiveActivity()
            }
        }
    }
    
    @available(iOS 16.1, *)
    func toggleLiveActivity() {
        if liveActivityActive {
            endLiveActivity()
        } else {
            startLiveActivity()
        }
    }
    
    @available(iOS 16.1, *)
    private func startLiveActivity() {
        let attributes = StopwatchAttributes()
        let contentState = StopwatchAttributes.ContentState(
            elapsedTime: elapsedTime,
            isRunning: isRunning
        )
        
        do {
            currentActivity = try Activity<StopwatchAttributes>.request(
                attributes: attributes,
                contentState: contentState,
                pushType: nil
            )
            liveActivityActive = true
        } catch {
            print("Error starting Live Activity: \(error)")
        }
    }
    
    @available(iOS 16.1, *)
    private func updateLiveActivity() {
        guard let activity = currentActivity else { return }
        
        let contentState = StopwatchAttributes.ContentState(
            elapsedTime: elapsedTime,
            isRunning: isRunning
        )
        
        Task {
            await activity.update(using: contentState)
        }
    }
    
    @available(iOS 16.1, *)
    private func endLiveActivity() {
        guard let activity = currentActivity else { return }
        
        Task {
            await activity.end(dismissalPolicy: .immediate)
            await MainActor.run {
                self.currentActivity = nil
                self.liveActivityActive = false
            }
        }
    }
}

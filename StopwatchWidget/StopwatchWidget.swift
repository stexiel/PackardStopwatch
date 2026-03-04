import ActivityKit
import WidgetKit
import SwiftUI
import AppIntents

struct StopwatchLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StopwatchAttributes.self) { context in
            // Lock screen/banner UI with interactive buttons
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Packard Stopwatch")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(timeString(from: context.state.elapsedTime))
                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                            .foregroundColor(context.state.isRunning ? .green : .red)
                    }
                    
                    Spacer()
                    
                    Image(systemName: context.state.isRunning ? "play.circle.fill" : "pause.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(context.state.isRunning ? .green : .red)
                }
                
                // Interactive buttons for iOS 17+
                if #available(iOS 17.0, *) {
                    HStack(spacing: 16) {
                        Button(intent: ToggleStopwatchIntent()) {
                            HStack {
                                Image(systemName: context.state.isRunning ? "pause.fill" : "play.fill")
                                Text(context.state.isRunning ? "Pause" : "Resume")
                            }
                            .font(.caption)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(context.state.isRunning ? Color.orange : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                        
                        Button(intent: ResetStopwatchIntent()) {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                Text("Reset")
                            }
                            .font(.caption)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
            .activityBackgroundTint(Color.black.opacity(0.8))
            .activitySystemActionForegroundColor(Color.white)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI with interactive buttons
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Packard")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Image(systemName: context.state.isRunning ? "play.circle.fill" : "pause.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(context.state.isRunning ? .green : .red)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(context.state.isRunning ? "Running" : "Paused")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(shortTimeString(from: context.state.elapsedTime))
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundColor(context.state.isRunning ? .green : .red)
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(timeString(from: context.state.elapsedTime))
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                        .foregroundColor(context.state.isRunning ? .green : .red)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    if #available(iOS 17.0, *) {
                        HStack(spacing: 12) {
                            Button(intent: ToggleStopwatchIntent()) {
                                Label(context.state.isRunning ? "Pause" : "Resume", 
                                      systemImage: context.state.isRunning ? "pause.fill" : "play.fill")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(context.state.isRunning ? Color.orange : Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .buttonStyle(.plain)
                            
                            Button(intent: ResetStopwatchIntent()) {
                                Label("Reset", systemImage: "arrow.counterclockwise")
                                    .font(.caption)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal)
                    }
                }
            } compactLeading: {
                Image(systemName: "timer")
                    .foregroundColor(context.state.isRunning ? .green : .red)
            } compactTrailing: {
                Text(shortTimeString(from: context.state.elapsedTime))
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(context.state.isRunning ? .green : .red)
            } minimal: {
                Image(systemName: "timer")
                    .foregroundColor(context.state.isRunning ? .green : .red)
            }
        }
    }
    
    func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        let milliseconds = Int((timeInterval.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    func shortTimeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

@main
struct StopwatchWidgetBundle: WidgetBundle {
    var body: some Widget {
        StopwatchLiveActivity()
    }
}

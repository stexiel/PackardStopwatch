import ActivityKit
import WidgetKit
import SwiftUI

struct StopwatchAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var elapsedTime: TimeInterval
        var isRunning: Bool
    }
}

struct StopwatchLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StopwatchAttributes.self) { context in
            // Lock screen/banner UI
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
            .padding()
            .activityBackgroundTint(Color.black.opacity(0.8))
            .activitySystemActionForegroundColor(Color.white)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: context.state.isRunning ? "play.circle.fill" : "pause.circle.fill")
                        .foregroundColor(context.state.isRunning ? .green : .red)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.isRunning ? "Running" : "Paused")
                        .font(.caption)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(timeString(from: context.state.elapsedTime))
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                        .foregroundColor(context.state.isRunning ? .green : .red)
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

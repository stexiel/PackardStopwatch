import AppIntents
import ActivityKit

@available(iOS 17.0, *)
struct ToggleStopwatchIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Toggle Stopwatch"
    
    func perform() async throws -> some IntentResult {
        // Post notification to toggle stopwatch
        NotificationCenter.default.post(name: .toggleStopwatch, object: nil)
        return .result()
    }
}

@available(iOS 17.0, *)
struct ResetStopwatchIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Reset Stopwatch"
    
    func perform() async throws -> some IntentResult {
        // Post notification to reset stopwatch
        NotificationCenter.default.post(name: .resetStopwatch, object: nil)
        return .result()
    }
}

extension Notification.Name {
    static let toggleStopwatch = Notification.Name("toggleStopwatch")
    static let resetStopwatch = Notification.Name("resetStopwatch")
}

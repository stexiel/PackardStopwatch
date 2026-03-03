import ActivityKit
import Foundation

struct StopwatchAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var elapsedTime: TimeInterval
        var isRunning: Bool
    }
}

import Foundation
import ActivityKit
import Flutter

@available(iOS 16.1, *)
class LiveActivityManager {
    static let shared = LiveActivityManager()
    private var currentActivity: Activity<StopwatchAttributes>?
    
    func startLiveActivity(elapsedTime: TimeInterval, isRunning: Bool) {
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
        } catch {
            print("Error starting Live Activity: \(error)")
        }
    }
    
    func updateLiveActivity(elapsedTime: TimeInterval, isRunning: Bool) {
        guard let activity = currentActivity else { return }
        
        let contentState = StopwatchAttributes.ContentState(
            elapsedTime: elapsedTime,
            isRunning: isRunning
        )
        
        Task {
            await activity.update(using: contentState)
        }
    }
    
    func endLiveActivity() {
        guard let activity = currentActivity else { return }
        
        Task {
            await activity.end(dismissalPolicy: .immediate)
            currentActivity = nil
        }
    }
}

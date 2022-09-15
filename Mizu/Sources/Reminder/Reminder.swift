import Foundation

class Reminder {
    
    private var timer: Timer?
    private let preferences = Preferences()
    var onTimerProgression: ((Int) -> Void)?
    var timerProgress: Int = 0
    
    func startTimer() {
        let intervalInSecs = Interval().seconds() / 8
        
        self.timerProgress = 0
        timer = Timer.scheduledTimer(timeInterval: intervalInSecs,
                                     target: self,
                                     selector: #selector(progressTimer),
                                     userInfo: nil, repeats: true)
    }
    
    @objc private func progressTimer() {
        self.timerProgress += 1
        
        if self.timerProgress == 8 {
            self.timerProgress = 0
            self.showNotification()
        }
        
        self.onTimerProgression?(self.timerProgress)
    }
    
    private func showNotification() {
        let notification = NSUserNotification()
        notification.title = "Time to drink water"
        notification.informativeText = "It's been \(Interval().string()) since your last glass."
        notification.hasActionButton = true
        notification.otherButtonTitle = "Dismiss"
        notification.actionButtonTitle = "OK"
        
        if preferences.isSoundEnabled() {
            notification.soundName = NSUserNotificationDefaultSoundName
        }
        
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.deliver(notification)
    }
    
    func reset() {
        timer?.invalidate()
        startTimer()
    }
}

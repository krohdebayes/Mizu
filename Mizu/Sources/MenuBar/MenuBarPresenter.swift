import Cocoa

final class MenuBarPresenter {
    
    private let reminder: Reminder
    private var popover: NSPopover?
    
    init(reminder: Reminder = Reminder()) {
        self.reminder = reminder
        self.popover = nil
    }
    
    func launch() {
        reminder.startTimer()
    }
    
    func statusItemTap(statusItem: NSStatusItem) {
        if self.popover?.isShown == true {
            self.popover?.close()
            self.popover = nil
            return
        }
        
        if let button = statusItem.button {
            let popover = NSPopover()
            let vc = PreferencesViewController.newInstance()
            
            popover.contentViewController = vc
            
            vc.intervalChanged = { self.resetTimer() }
            vc.onClose = { popover.close() }
            
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            
            self.popover = popover
        }
    }
    
    private func resetTimer() {
        reminder.reset()
    }
    
}

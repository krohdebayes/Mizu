import Cocoa

final class MenuBar: NSObject {
    
    private let presenter = MenuBarPresenter()
    private let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    func launch() {
        initStatusBar()
        presenter.onLaunch(timerProgressionCallback: self.updateStatusItemButton)
    }
    
    private func initStatusBar() {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarImage"))
            button.action = #selector(statusItemTap(_:))
            button.target = self
        }
    }
    
    private func updateStatusItemButton(stage: Int) {
        if let button = statusItem.button {
            var buttonImageName = "StatusBarImage"
            switch stage {
            case 0:
                buttonImageName = "StatusBarImage"
            case 1:
                buttonImageName = "StatusBarImage-45"
            case 2:
                buttonImageName = "StatusBarImage-90"
            case 3:
                buttonImageName = "StatusBarImage-135"
            case 4:
                buttonImageName = "StatusBarImage-180"
            case 5:
                buttonImageName = "StatusBarImage-225"
            case 6:
                buttonImageName = "StatusBarImage-270"
            case 7:
                buttonImageName = "StatusBarImage-315"
            default:
                break
            }
            
            button.image = NSImage(named:NSImage.Name(buttonImageName))
        }
    }
    
    @objc private func statusItemTap(_ sender: NSStatusBarButton) {
        presenter.onStatusItemTap(statusItem: statusItem)
    }
}

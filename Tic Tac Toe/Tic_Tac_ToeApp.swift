import SwiftUI

@main
struct NotSusPiciousApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 325, minHeight: 400) // Set minimum size for the window
        }
        .windowStyle(DefaultWindowStyle()) // Optional: specify the window style if needed
        .windowToolbarStyle(UnifiedWindowToolbarStyle()) // Optional: customize toolbar style
        .commands {
            CommandGroup(replacing: .newItem) {
                // Disable new window command to keep the window's size constrained
            }
        }
    }
}

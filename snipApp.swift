//
//  snipApp.swift
//  snip
//
//  Created by Mitchell Cohen on 12/29/24.
//

import SwiftUI

@main
struct SnipApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            // Optional: A settings window if needed
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem?
    var popover: NSPopover?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide dock icon
        NSApp.setActivationPolicy(.accessory)
        
        setupStatusBarItem()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        NSStatusBar.system.removeStatusItem(statusBarItem!)
    }
    
    private func setupStatusBarItem() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusBarItem?.button {
            button.image = NSImage(systemSymbolName: "note.text", accessibilityDescription: "Snip Notes")
            button.action = #selector(togglePopover)
        }
        
        let popover = NSPopover()
        popover.contentViewController = NSHostingController(rootView: ContentView())
        popover.behavior = .transient
        popover.contentSize = NSSize(width: 400, height: 500)
        
        if let field = popover.contentViewController?.view.window?.standardWindowButton(.zoomButton) {
            field.isEnabled = true
        }
        
        self.popover = popover
    }
    
    @objc func togglePopover() {
        guard let button = statusBarItem?.button else { return }
        if let popover = self.popover {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}

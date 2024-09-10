//
//  AppDelegate.swift
//  Sortrr
//
//  Created by Mehdi Merkachi on 09/09/2024.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var sorter = Sorter()
    var settingsWindow: NSWindow?
    var settings = Settings() // Create the Settings instance

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set up the menu bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "folder", accessibilityDescription: "Sortrr")
        }
        
        // Set up the menu
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Sort Now", action: #selector(sortNow), keyEquivalent: "S"))
        menu.addItem(NSMenuItem(title: "Settings", action: #selector(openSettings), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "Q"))
        
        statusItem?.menu = menu
    }

    @objc func openSettings() {
        if settingsWindow == nil {
            // Create the settings window if it doesn't exist
            settingsWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered, defer: false)
            settingsWindow?.title = "Settings"
            settingsWindow?.center()
            settingsWindow?.contentView = NSHostingView(rootView: SettingsView(settings: settings)) // Pass settings instance
            settingsWindow?.makeKeyAndOrderFront(nil)
            settingsWindow?.isReleasedWhenClosed = false
        } else {
            settingsWindow?.makeKeyAndOrderFront(nil)
        }
    }

    @objc func sortNow() {
        sorter.sortDownloads()
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
}

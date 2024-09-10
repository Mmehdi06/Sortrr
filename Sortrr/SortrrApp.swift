import SwiftUI

@main struct SortrrApp: App {
    @StateObject var sorter = Sorter()

    var body: some Scene {
        MenuBarExtra("UtilityApp", systemImage: "tray.and.arrow.down.fill"){
                AppMenu(sorter: sorter)
            }.menuBarExtraStyle(.window)

            WindowGroup{
                EmptyView()
            }
        }
}

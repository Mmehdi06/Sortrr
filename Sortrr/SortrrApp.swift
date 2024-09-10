import SwiftUI

@main 
struct SortrrApp: App {
    @StateObject var sorter = Sorter()
    

    var body: some Scene {
        MenuBarExtra("SORTRR", image: "MenuIcon"  ){
                AppMenu(sorter: sorter)
            }.menuBarExtraStyle(.window)
        }
}

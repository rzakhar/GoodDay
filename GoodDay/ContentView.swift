/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that presents the app's user interface.
*/

import SwiftUI

// The app uses `LibraryView` as its main UI.
struct ContentView: View {
    
    /// The library's selection path.
    @State private var navigationPath = [Space]()
    /// A Boolean value that indicates whether the app is currently presenting an immersive space.
    @State private var isPresentingSpace = false
    /// The app's player model.

    var body: some View {
        LibraryView(path: $navigationPath, isPresentingSpace: $isPresentingSpace)
    }
}

#Preview {
    ContentView()
        .environment(SpaceLibrary())
}

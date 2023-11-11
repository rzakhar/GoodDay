/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main app structure.
*/

import SwiftUI
import os

@main
struct GoodDay: App {
    
    /// An object that manages the library of space content.
    @State private var library = SpaceLibrary()
    
    var body: some Scene {
        // The app's primary content window.
        WindowGroup {
            ContentView()
                .environment(library)
                // Use a dark color scheme on supported platforms.
                .preferredColorScheme(.dark)
                .tint(.white)
        }
        // Defines an immersive space to present a destination in which to watch the space.
        ImmersiveSpace(for: Destination.self) { $destination in
            if let destination {
                DestinationView(destination)
            }
        }
        // Set the immersion style to progressive, so the user can use the crown to dial in their experience.
        .immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}

/// A global logger for the app.
let logger = Logger()

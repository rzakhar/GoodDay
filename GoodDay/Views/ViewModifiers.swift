/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Custom view modifiers that the app defines.
*/

import SwiftUI

extension View {
    #if os(visionOS)
    func updateImmersionOnChange(of path: Binding<[Space]>, isPresentingSpace: Binding<Bool>) -> some View {
        self.modifier(ImmersiveSpacePresentationModifier(navigationPath: path, isPresentingSpace: isPresentingSpace))
    }
    #endif
}

#if os(visionOS)
private struct ImmersiveSpacePresentationModifier: ViewModifier {
    
    @Environment(\.openImmersiveSpace) private var openSpace
    @Environment(\.dismissImmersiveSpace) private var dismissSpace
    /// The current phase for the scene, which can be active, inactive, or background.
    @Environment(\.scenePhase) private var scenePhase
    
    @Binding var navigationPath: [Space]
    @Binding var isPresentingSpace: Bool
    
    func body(content: Content) -> some View {
        content
            .onChange(of: navigationPath) {
                Task {
                    // The selection path becomes empty when the user returns to the main library window.
                    if navigationPath.isEmpty {
                        if isPresentingSpace {
                            // Dismiss the space and return the user to their real-world space.
                            await dismissSpace()
                            isPresentingSpace = false
                        }
                    } else {
                        guard !isPresentingSpace else { return }
                        // The navigationPath has one space, or is empty.
                        guard let space = navigationPath.first else { fatalError() }
                        // Await the request to open the destination and set the state accordingly.
                        switch await openSpace(value: space.destination) {
                        case .opened: isPresentingSpace = true
                        default: isPresentingSpace = false
                        }
                    }
                }
            }
            // Close the space and unload media when the user backgrounds the app.
            .onChange(of: scenePhase) { _, newPhase in
                if isPresentingSpace, newPhase == .background {
                    Task {
                        await dismissSpace()
                    }
                }
            }
    }
}
#endif

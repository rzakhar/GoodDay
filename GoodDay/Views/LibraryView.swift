/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays the list of spaces the library contains.
*/
import SwiftUI

/// A view that presents the app's content library.
///
/// This view provides the app's main user interface. It displays two
/// horizontally scrolling rows of spaces. The top row displays full-sized
/// cards that represent the Featured spaces in the app. The bottom row
/// displays spaces that the user adds to their Favorites queue.
///
struct LibraryView: View {
    
    @Environment(SpaceLibrary.self) private var library
    
    /// A path that represents the user's content navigation path.
    @Binding private var navigationPath: [Space]
    /// A path that represents the user's content navigation path.
    @Binding private var isPresentingSpace: Bool
    
    /// Creates a `LibraryView` with a binding to a selection path.
    ///
    /// The default value is an empty binding.
    init(path: Binding<[Space]>, isPresentingSpace: Binding<Bool> = .constant(false)) {
        _navigationPath = path
        _isPresentingSpace = isPresentingSpace
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            // Wrap the content in a vertically scrolling view.
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: verticalPadding) {
                    // Displays the Good Day logo image.
                    Image("dv_logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.leading, outerPadding)
                        .padding(.bottom, isMobile ? 0 : 8)
                        .frame(height: logoHeight)
                        .accessibilityHidden(true)
                    
                    // Displays a horizontally scrolling list of Featured spaces.
                    SpaceListView(title: "Featured",
                                  spaces: library.spaces,
                                  cardStyle: .full,
                                  cardSpacing: horizontalSpacing)
                    
                    // Displays a horizontally scrolling list of spaces in the user's Favorites queue.
                    SpaceListView(title: "Favorites",
                                  spaces: library.vaforites,
                                  cardStyle: .vaforites,
                                  cardSpacing: horizontalSpacing)
                }
                .padding([.top, .bottom], verticalPadding)
                .navigationDestination(for: Space.self) { space in
                    DetailView(space: space)
                        .navigationTitle(space.title)
                        .navigationBarHidden(isTV)
                }
            }
            #if os(tvOS)
            .ignoresSafeArea()
            #endif
        }
        #if os(visionOS)
        // A custom view modifier that presents an immersive space when you navigate to the detail view.
        .updateImmersionOnChange(of: $navigationPath, isPresentingSpace: $isPresentingSpace)
        #endif
        .overlay(alignment: .topTrailing) {
            BeatingHeart()
                .padding(.all, 30)
        }
    }

    // MARK: - Platform-specific metrics.
    
    /// The vertical padding between views.
    var verticalPadding: Double {
        valueFor(iOS: 30, tvOS: 40, visionOS: 30)
    }
    
    var outerPadding: Double {
        valueFor(iOS: 20, tvOS: 50, visionOS: 30)
    }
    
    var horizontalSpacing: Double {
        valueFor(iOS: 20, tvOS: 80, visionOS: 30)
    }
    
    var logoHeight: Double {
        valueFor(iOS: 24, tvOS: 60, visionOS: 34)
    }
}

#Preview {
    NavigationStack {
        LibraryView(path: .constant([]))
            .environment(SpaceLibrary())
    }
}

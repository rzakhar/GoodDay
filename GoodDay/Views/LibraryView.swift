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
                VStack(alignment: .leading, spacing: 30) {
                    // Displays the Good Day logo image.
                    LinearGradient(
                        colors: [.orange, .blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width:300, height: 50)
                    .mask(
                        Text("Good Day")
                            .font(Font.system(size: 46, weight: .bold))
                            .multilineTextAlignment(.center)
                    )
                    .shadow(radius: 10)



                    SpaceListView(title: "Early Riser",
                                  subtitle: "Good morning!",
                                  spaces: library.morningSpaces,
                                  cardStyle: .full,
                                  cardSpacing: 30)
                    SpaceListView(title: "The Inner Calm",
                                  subtitle: "Try to lower your heart rate",
                                  spaces: library.calmSpaces,
                                  cardStyle: .full,
                                  cardSpacing: 30)
                    SpaceListView(title: "Mindful Weekend",
                                  subtitle: "Your Sundays favorites",
                                  spaces: library.spiritualSpaces,
                                  cardStyle: .full,
                                  cardSpacing: 30)
                    SpaceListView(title: "All Spaces",
                                  subtitle: "The whole Good Day library",
                                  spaces: library.spaces,
                                  cardStyle: .full,
                                  cardSpacing: 30)

                    // Displays a horizontally scrolling list of spaces in the user's Favorites queue.
                    SpaceListView(title: "Favorites",
                                  spaces: library.favorites,
                                  cardStyle: .favorites,
                                  cardSpacing: 30)
                }
                .padding([.top, .bottom], 30)
                .navigationDestination(for: Space.self) { space in
                    DetailView(space: space)
                        .navigationTitle(space.title)
                }
            }
        }
        // A custom view modifier that presents an immersive space when you navigate to the detail view.
        .updateImmersionOnChange(of: $navigationPath, isPresentingSpace: $isPresentingSpace)
        .overlay(alignment: .topTrailing) {
            BeatingHeart()
                .padding(.all, 30)
        }
    }
}

#Preview {
    NavigationStack {
        LibraryView(path: .constant([]))
            .environment(SpaceLibrary())
    }
}

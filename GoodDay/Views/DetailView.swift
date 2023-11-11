/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that presents a horizontal view of the space details.
*/

import SwiftUI

// The leading side of view displays a trailer view, and the trailing side displays space information and action controls.
struct DetailView: View {
    
    let space: Space
    @Environment(SpaceLibrary.self) private var library
    
    let margins = 30.0
    
    var body: some View {
        VStack(alignment: .leading) {
            // Displays space details.
            SpaceInfoView(space: space)
            // Action controls.
            HStack {
                Group {
                    Button {
                        // Calling this method toggles the space's inclusion state in the Favorites queue.
                        library.toggleFavoriteState(for: space)
                    } label: {
                        let isFavorite = library.isspaceInFavorite(space)
                        Label(isFavorite ? "In Favorites" : "Add to Favorites",
                              systemImage: isFavorite ? "checkmark" : "plus")
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white.opacity(0.3))
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: 420)
            Spacer()
        }
        .padding(margins)
    }
}

#Preview {
    NavigationStack {
        DetailView(space: .preview)
            .environment(SpaceLibrary())
    }
}

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
        HStack(alignment: .top, spacing: margins) {
            // A view that plays space in an inline presentation.
            Color.red
                .aspectRatio(16 / 9, contentMode: .fit)
                .frame(width: 620)
                .cornerRadius(20)
            
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
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: 420)
                Spacer()
            }
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

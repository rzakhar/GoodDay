/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that display space detail in a wide layout.
*/

import SwiftUI

/// A view that displays action controls and space detail in a horizontal layout.
///
/// The detail view in iPadOS and tvOS use this view to display the space information.
struct WideDetailView: View {
    
    let space: Space
    let library: SpaceLibrary
    
    var body: some View {
        // Arrange the content in a horizontal layout.
        HStack(alignment: .top, spacing: isTV ? 40 : 20) {
            VStack {
                // A button to toggle whether the space is in the user's Favorites queue.
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
            .fontWeight(.semibold)
            .foregroundStyle(.black)
            .buttonStyle(.borderedProminent)
            .frame(width: isTV ? 400 : 200)
            // Make the buttons the same width.
            .fixedSize(horizontal: true, vertical: false)
            
            Text(space.description)
            
            VStack(alignment: .leading, spacing: 4) {
                RoleView(role: "Stars", people: space.info.stars)
                RoleView(role: "Director", people: space.info.directors)
                RoleView(role: "Writers", people: space.info.writers)
            }
            
        }
        .frame(height: isTV ? 300 : 150)
        .padding([.leading, .trailing], isTV ? 80 : 40)
        .padding(.bottom, 20)
    }
}


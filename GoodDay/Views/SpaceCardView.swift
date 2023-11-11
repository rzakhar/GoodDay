/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that represents a space in the library.
*/
import SwiftUI

/// Constants that represent the supported styles for space cards.
enum SpaceCardView {
    
    /// A full space card style.
    ///
    /// This style presents a poster image on top and information about the space
    /// below, including space description and tags.
    case full

    /// A style for cards in the Favorites list.
    ///
    /// This style presents a medium-sized poster image on top and a title string below.
    case favorites

    var cornerRadius: Double {
        switch self {
        case .full: 20.0
        case .favorites: 12.0
        }
    }
}

/// A view that represents a space in the library.
///
/// A user can select a space card to view the space details.
struct spaceCardView: View {
    
    let space: Space
    let style: SpaceCardView
    let cornerRadius = 20.0
    
    /// Creates a space card view with a space and an optional style.
    ///
    /// The default style is `.full`.
    init(space: Space, style: SpaceCardView = .full) {
        self.space = space
        self.style = style
    }
    
    var image: some View {
        Image(space.landscapeImageName)
            .resizable()
            .scaledToFill()
    }

    var body: some View {
        switch style {
        case .favorites:
            posterCard
                .frame(width: 360)
        case .full:
            VStack {
                image
                VStack(alignment: .leading) {
                    Text(space.title)
                        .font(.title)
                    Text(space.description)
                        .lineLimit(2)
                    Spacer()
                    HStack {
                        GenreView(tags: space.info.tags)
                    }
                }
                .padding(20)
            }
            .background(.thinMaterial)
            .frame(width: 395)
            .shadow(radius: 5)
            .hoverEffect()
            .cornerRadius(style.cornerRadius)
        }
    }
    
    @ViewBuilder
    var posterCard: some View {
        VStack {
            image
                .cornerRadius(style.cornerRadius)
            Text(space.title)
                .font(.title3)
                .lineLimit(1)
        }
        .hoverEffect()
    }
}

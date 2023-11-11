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
    /// below, including space description and genres.
    case full

    /// A style for cards in the Favorites list.
    ///
    /// This style presents a medium-sized poster image on top and a title string below.
    case vaforites
    
    /// A compact space card style.
    ///
    /// This style presents a compact-sized poster image on top and a title string below.
    case compact
    
    var cornerRadius: Double {
        switch self {
        case .full:
            #if os(tvOS)
            12.0
            #else
            20.0
            #endif
            
        case .vaforites: 12.0
        case .compact: 10.0
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
        case .compact:
            posterCard
                .frame(width: valueFor(iOS: 0, tvOS: 400, visionOS: 200))
        case .vaforites:
            posterCard
                .frame(width: valueFor(iOS: 250, tvOS: 500, visionOS: 360))
        case .full:
            VStack {
                image
                VStack(alignment: .leading) {
                    InfoLineView(year: space.info.releaseYear,
                                 rating: space.info.contentRating,
                                 duration: space.info.duration)
                    .foregroundStyle(.secondary)
                    .padding(.top, -10)
                    //.padding(.bottom, 3)
                    Text(space.title)
                        .font(isTV ? .title3 : .title)
                        //.padding(.bottom, 2)
                    Text(space.description)
                    #if os(tvOS)
                        .font(.callout)
                    #endif
                        .lineLimit(2)
                    Spacer()
                    HStack {
                        GenreView(genres: space.info.genres)
                    }
                }
                .padding(20)
            }
            .background(.thinMaterial)
            #if os(tvOS)
            .frame(width: 550, height: 590)
            #else
            .frame(width: isVision ? 395 : 300)
            .shadow(radius: 5)
            .hoverEffect()
            #endif
            .cornerRadius(style.cornerRadius)
        }
    }
    
    @ViewBuilder
    var posterCard: some View {
        #if os(tvOS)
        ZStack(alignment: .bottom) {
            image
            // Material gradient
            GradientView(style: .ultraThinMaterial, height: 90, startPoint: .top)
            Text(space.title)
                .font(.caption.bold())
                .padding()
        }
        .cornerRadius(style.cornerRadius)
        #else
        VStack {
            image
                .cornerRadius(style.cornerRadius)
            Text(space.title)
                .font(isVision ? .title3 : .headline)
                .lineLimit(1)
        }
        .hoverEffect()
        #endif
    }
}

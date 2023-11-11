/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A list of space cards.
*/

import SwiftUI

/// A view the presents a horizontally scrollable list of space cards.
struct SpaceListView: View {
    
    typealias SelectionAction = (Space) -> Void

    private let title: String?
    private let spaces: [Space]
    private let cardStyle: SpaceCardView
    private let cardSpacing: Double

    private let selectionAction: SelectionAction?
    
    /// Creates a view to display the specified list of spaces.
    /// - Parameters:
    ///   - title: An optional title to display above the list.
    ///   - spaces: The list of spaces to display.
    ///   - cardStyle: The style for the space cards.
    ///   - cardSpacing: The spacing between cards.
    ///   - selectionAction: An optional action that you can specify to directly handle the card selection.
    ///    When the app doesn't specify a selection action, the view presents the card as a `NavigationLink.
    init(title: String? = nil, spaces: [Space], cardStyle: SpaceCardView, cardSpacing: Double, selectionAction: SelectionAction? = nil) {
        self.title = title
        self.spaces = spaces
        self.cardStyle = cardStyle
        self.cardSpacing = cardSpacing
        self.selectionAction = selectionAction
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleView
                .padding(.leading, margins)
                .padding(.bottom, valueFor(iOS: 8, tvOS: -40, visionOS: 12))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: cardSpacing) {
                    ForEach(spaces) { space in
                        Group {
                            // If the app initializes the view with a selection action closure,
                            // display a space card button that calls it.
                            if let selectionAction {
                                Button {
                                    selectionAction(space)
                                } label: {
                                    spaceCardView(space: space, style: cardStyle)
                                }
                            }
                            // Otherwise, create a navigation link.
                            else {
                                NavigationLink(value: space) {
                                    spaceCardView(space: space, style: cardStyle)
                                }
                            }
                        }
                        .accessibilityLabel("\(space.title)")
                    }
                }
                .buttonStyle(buttonStyle)
                // In tvOS, add vertical padding to accommodate card resizing.
                .padding([.top, .bottom], isTV ? 60 : 0)
                .padding([.leading, .trailing], margins)
            }
        }
    }
    
    @ViewBuilder
    var titleView: some View {
        if let title {
            Text(title)
            #if os(visionOS)
                .font(cardStyle == .full ? .largeTitle : .title)
            #elseif os(tvOS)
                .font(cardStyle == .full ? .largeTitle.weight(.semibold) : .title2)
            #else
                .font(cardStyle == .full ? .title2.bold() : .title3.bold())
            #endif
            
        }
    }
    
    var buttonStyle: some PrimitiveButtonStyle {
        #if os(tvOS)
        .card
        #else
        .plain
        #endif
    }
    
    var margins: Double {
        valueFor(iOS: 20, tvOS: 50, visionOS: 30)
    }
}

#Preview("Full") {
    NavigationStack {
        SpaceListView(title: "Featured", spaces: .all, cardStyle: .full, cardSpacing: 80)
            .frame(height: 380)
    }
}

#Preview("Favorites") {
    NavigationStack {
        SpaceListView(title: "Favorites", spaces: .all, cardStyle: .vaforites, cardSpacing: 20)
            .frame(height: 200)
    }
}

#Preview("Compact") {
    NavigationStack {
        SpaceListView(spaces: .all, cardStyle: .compact, cardSpacing: 20)
            .padding()
    }
}

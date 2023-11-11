/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that presents a horizontal view of the video details.
*/

import SwiftUI

// The leading side of view displays a trailer view, and the trailing side displays video information and action controls.
struct DetailView: View {
    
    let video: Space
    @Environment(SpaceLibrary.self) private var library
    
    let margins = 30.0
    
    var body: some View {
        HStack(alignment: .top, spacing: margins) {
            // A view that plays video in an inline presentation.
            Color.red
                .aspectRatio(16 / 9, contentMode: .fit)
                .frame(width: 620)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                // Displays video details.
                SpaceInfoView(video: video)
                // Action controls.
                HStack {
                    Group {
                        Button {
                            // Calling this method toggles the video's inclusion state in the Up Next queue.
                            library.toggleUpNextState(for: video)
                        } label: {
                            let isUpNext = library.isVideoInUpNext(video)
                            Label(isUpNext ? "In Up Next" : "Add to Up Next",
                                  systemImage: isUpNext ? "checkmark" : "plus")
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
        DetailView(video: .preview)
            .environment(SpaceLibrary())
    }
}

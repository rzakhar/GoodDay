/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that displays information about a space like its title, actors, and rating.
*/
import SwiftUI

struct SpaceInfoView: View {
    let space: Space
    var body: some View {
        VStack(alignment: .leading) {
            Text(space.title)
                .font(.title)
                .padding(.bottom, 4)
            InfoLineView(year: space.info.releaseYear,
                         rating: space.info.contentRating,
                         duration: space.info.duration)
                .padding([.bottom], 4)
            GenreView(genres: space.info.genres)
                .padding(.bottom, 4)
            RoleView(role: String(localized: "Stars"), people: space.info.stars)
                .padding(.top, 1)
            RoleView(role: String(localized: "Director"), people: space.info.directors)
                .padding(.top, 1)
            RoleView(role: String(localized: "Writers"), people: space.info.writers)
                .padding(.top, 1)
                .padding(.bottom, 12)
            Text(space.description)
                .font(.headline)
                .padding(.bottom, 12)
        }
    }
}

/// A view that displays a horizontal list of the space's year, rating, and duration.
struct InfoLineView: View {
    let year: String
    let rating: String
    let duration: String
    var body: some View {
        HStack {
            Text("\(year) | \(rating) | \(duration)")
                .font(.subheadline.weight(.medium))
        }
    }
}

/// A view that displays a comma-separated list of genres for a space.
struct GenreView: View {
    let genres: [String]
    var body: some View {
        HStack(spacing: 8) {
            ForEach(genres, id: \.self) {
                Text($0)
                    .fixedSize()
                    .font(.caption2.weight(.bold))
                    .padding([.leading, .trailing], 4)
                    .padding([.top, .bottom], 4)
                    .background(RoundedRectangle(cornerRadius: 5).stroke())
                    .foregroundStyle(.secondary)
            }
            // Push the list to the leading edge.
            Spacer()
        }
    }
}

/// A view that displays a name of a role, followed by one or more people who hold the position.
struct RoleView: View {
    let role: String
    let people: [String]
    var body: some View {
        VStack(alignment: .leading) {
            Text(role)
            Text(people.formatted())
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SpaceInfoView(space: .preview)
        .padding()
        .frame(width: 500, height: 500)
        .background(.gray)
        .previewLayout(.sizeThatFits)
}

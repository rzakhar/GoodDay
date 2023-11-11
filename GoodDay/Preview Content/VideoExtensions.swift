/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Extensions to simplify creating previews.
*/

import Foundation

extension Space {
    static var preview: Space {
        SpaceLibrary().spaces[0]
    }
}

extension Array {
    static var all: [Space] {
        SpaceLibrary().spaces
    }
}


/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An object that represents a space in the app's library.
*/

import Foundation
import UIKit

struct Space: Identifiable, Hashable, Codable {
    
    /// The unique identifier of the item.
    let id: Int
    /// The URL of the space, which can be local or remote.
    let title: String
    /// The base image name.
    let imageName: String
    /// The description of the space.
    let description: String
    /// The name of the space's portrait image.
    var portraitImageName: String { "\(imageName)_portrait" }
    /// The name of the space's landscape image.
    var landscapeImageName: String { "\(imageName)_landscape" }
    /// The data for the landscape image to create a metadata item to display in the Info panel.
    var imageData: Data {
        UIImage(named: landscapeImageName)?.pngData() ?? Data()
    }
    /// Detailed information about the space
    let info: Info

    /// A destination in which to watch the space.
    /// The app presents this destination in an immersive space.
    var destination: Destination
    
    /// An object that provides detailed information for a space.
    struct Info: Hashable, Codable {
        var tags: [String]
    }
}

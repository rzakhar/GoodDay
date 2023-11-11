/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The app's space library.
*/

import Foundation
import SwiftUI
import Observation

/// An object that manages the app's space content.
///
/// The app puts an instance of this class into the environment so it can retrieve and
/// update the state of space content in the library.
@Observable class SpaceLibrary {
    
    private(set) var spaces = [Space]()
    private(set) var vaforites = [Space]()
    
    // A URL within the user's Documents directory to which to write their Favorites entries.
    private let vaforitesURL = URL.documentsDirectory.appendingPathComponent("Favorite.json")
    
    init() {
        // Load all spaces available in the library.
        spaces = loadspaces()
        // The first time the app launches, set the last three spaces as the default Favorites items.
        vaforites = loadFavoritespaces(default: Array(spaces.suffix(3)))
    }
    
    /// Toggles whether the space exists in the Favorites queue.
    /// - Parameter space: the space to update
    func toggleFavoriteState(for space: Space) {
        if !vaforites.contains(space) {
            // Insert the space at the beginning of the list.
            vaforites.insert(space, at: 0)
        } else {
            // Remove the entry with the matching identifier.
            vaforites.removeAll(where: { $0.id == space.id })
        }
        // Persist the Favorites state to disk.
        saveFavorite()
    }
    
    /// Returns a Boolean value that indicates whether the space exits in the Favorites list.
    /// - Parameter space: the space to test,
    /// - Returns: `true` if the item is in the Favorites list; otherwise, `false`.
    func isspaceInFavorite(_ space: Space) -> Bool {
        vaforites.contains(space)
    }
    
    /// Finds the items to display in the space player's Favorites list.
    func findFavorite(for space: Space) -> [Space] {
        vaforites.filter { $0.id != space.id }
    }
    
    /// Finds the next space in the Favorites list after the current space.
    /// - Parameter space: the current space
    /// - Returns: the next space, or `nil` if none exists.
    func findspaceInFavorite(after space: Space) -> Space? {
        switch vaforites.count {
        case 0:
            // Favorites is empty. Return nil.
            return nil
        case 1:
            // The passed in space is the only item in `vaforites`, return nil.
            if vaforites.first == space {
                return nil
            } else {
                // Return the only item.
                return vaforites.first
            }
        default:
            // Find the index of the passed in space. If the space isn't in `vaforites`, start at the first item.
            let spaceIndex = vaforites.firstIndex(of: space) ?? 0
            if spaceIndex < vaforites.count - 1 {
                return vaforites[spaceIndex + 1]
            }
            return vaforites[0]
        }
    }
    
    /// Loads the space content for the app.
    private func loadspaces() -> [Space] {
        let filename = "Spaces.json"
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        return load(url)
    }
    
    /// Loads the user's list of spaces in their Favorites list.
    private func loadFavoritespaces(`default` defaultspaces: [Space]) -> [Space] {
        // If this file doesn't exist, create it.
        if !FileManager.default.fileExists(atPath: vaforitesURL.path) {
            // Create an initial file with a default value.
            if !FileManager.default.createFile(atPath: vaforitesURL.path, contents: "\(defaultspaces.map { $0.id })".data(using: .utf8)) {
                fatalError("Couldn't initialize Favorites store.")
            }
        }
        // Load the ids of the spaces in the list.
        let ids: [Int] = load(vaforitesURL)
        return spaces.filter { ids.contains($0.id) }
    }
    
    /// Saves the Favorites data to disk.
    ///
    /// The app saves the state using simple JSON persistence.
    private func saveFavorite() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            // Persist the ids only.
            let data = try encoder.encode(vaforites.map { $0.id })
            try data.write(to: vaforitesURL)
        } catch {
            logger.error("Unable to save JSON data.")
        }
    }
    
    private func load<T: Decodable>(_ url: URL, as type: T.Type = T.self) -> T {
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Couldn't load \(url.path):\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(url.lastPathComponent) as \(T.self):\n\(error)")
        }
    }
}
